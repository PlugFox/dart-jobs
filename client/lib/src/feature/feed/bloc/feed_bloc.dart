import 'dart:async';
import 'dart:math' as math;

import 'package:dart_jobs/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs_shared/models.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';

part 'feed_bloc.freezed.dart';

@freezed
class FeedEvent with _$FeedEvent {
  const FeedEvent._();

  /// Запросить самые новые элементы
  const factory FeedEvent.fetchRecent() = _FetchRecentFeedEvent;

  /// Запросить более старых элементов
  const factory FeedEvent.paginate() = _PaginateFeedEvent;

  /// Устанавливает новую фильтрацию
  const factory FeedEvent.setFilter(JobFilter newFilter) = _SetFilterFeedEvent;
}

@freezed
class FeedState with _$FeedState {
  const FeedState._();

  /// Список не заполнен
  bool get isEmpty => list.isEmpty;

  /// Список заполнен
  bool get isNotEmpty => list.isNotEmpty;

  /// Выполняется запрос
  bool get isProcessed => maybeMap<bool>(
        orElse: () => false,
        pagination: (_) => true,
        fetchingRecent: (_) => true,
      );

  /// Выполняется обработка/загрузка ленты старых записей
  /// [filter] - текущий отбор
  /// [list] - текущий список
  /// [endOfList] - достигнут конец списка и более старых элементов больше не будет
  const factory FeedState.fetchingRecent({
    required final JobFilter filter,
    required final List<Job> list,
    @Default(false) final bool endOfList,
  }) = _FetchingLatestFeedState;

  /// Выполняется обработка/загрузка ленты старых записей
  /// [filter] - текущий отбор
  /// [list] - текущий список
  /// [endOfList] - достигнут конец списка и более старых элементов больше не будет
  const factory FeedState.pagination({
    required final JobFilter filter,
    required final List<Job> list,
    @Default(false) final bool endOfList,
  }) = _PaginationFeedState;

  /// Заполненная лента
  /// [filter] - текущий отбор
  /// [list] - текущий список
  /// [endOfList] - достигнут конец списка и более старых элементов больше не будет
  const factory FeedState.idle({
    required final JobFilter filter,
    @Default(<Job>[]) final List<Job> list,
    @Default(false) final bool endOfList,
  }) = _IdleFeedState;

  /// Ошибка получения ленты
  /// [filter] - текущий отбор
  /// [list] - текущий список
  /// [message] - описание ошибки
  /// [endOfList] - достигнут конец списка и более старых элементов больше не будет
  const factory FeedState.error({
    required final JobFilter filter,
    required final List<Job> list,
    required final String message,
    @Default(false) final bool endOfList,
  }) = _ErrorFeedState;
}

class FeedBLoC extends Bloc<FeedEvent, FeedState> {
  final IJobRepository _repository;
  FeedBLoC({
    required final IJobRepository repository,
    final FeedState initialState = const FeedState.idle(filter: JobFilter()),
  })  : _repository = repository,
        super(initialState) {
    /// TODO: подписка на уведомления с сервера о новых элементах
  }

  @override
  Stream<FeedState> mapEventToState(final FeedEvent event) => event.when<Stream<FeedState>>(
        fetchRecent: _fetchRecent,
        paginate: _paginate,
        setFilter: _setFilter,
      );

  Stream<FeedState> _fetchRecent() async* {
    try {
      yield FeedState.fetchingRecent(
        filter: state.filter,
        list: state.list,
        endOfList: state.endOfList,
      );

      JobsChunk chunk;
      do {
        final updatedAfter = state.list.firstOrNull?.updated ?? DateTime.now().subtract(const Duration(days: 1));
        chunk = await _repository.getRecent(
          updatedAfter: updatedAfter,
          filter: state.filter,
        );

        // Список обновленных (их нужно исключить из предидущего состояния)
        // тк они будут перемещены в начало ленты
        final idsForExclusion = List<String>.of(
          chunk
              .where((e) => e.deletionMark || e.updated != e.created || e.updated == updatedAfter)
              .map<String>((e) => e.id),
        );
        await Future<void>.delayed(Duration.zero);

        // Исключаю из исходной коллекции обновленные и удаленные
        // а затем объединяю исходный список и обновление
        final list = await _reducedStateList(idsForExclusion).toList().then<List<Job>>(
              (list) => <Job>[
                ...chunk.where((e) => !e.deletionMark),
                ...list,
              ],
            );
        yield FeedState.fetchingRecent(
          list: list,
          filter: state.filter,
          endOfList: state.endOfList,
        );
      } while (!chunk.endOfList);
    } on Object catch (err) {
      l.e('Произошла ошибка при запросе последних элементов ленты: $err');
      yield FeedState.error(
        filter: state.filter,
        list: state.list,
        message: 'An error occurred while updating the feed',
        endOfList: state.endOfList,
      );
      rethrow;
    } finally {
      yield FeedState.idle(
        filter: state.filter,
        list: state.list,
        endOfList: state.endOfList,
      );
    }
  }

  Stream<FeedState> _paginate() async* {
    if (state.endOfList) {
      yield FeedState.idle(
        filter: state.filter,
        list: state.list,
        endOfList: true,
      );
    }
    try {
      yield FeedState.pagination(
        filter: state.filter,
        list: state.list,
        endOfList: false,
      );

      final updatedBefore = state.list.lastOrNull?.updated ?? DateTime.now().subtract(const Duration(days: 1));
      final chunk = await _repository.paginate(
        updatedBefore: updatedBefore,
        filter: state.filter,
      );

      // Список более старых (если updatedBefore совпадает с updated исключаю из предидущего состояния эти id)
      final idsForExclusion = List<String>.of(chunk.where((e) => e.updated == updatedBefore).map<String>((e) => e.id));
      await Future<void>.delayed(Duration.zero);

      // Исключаю из исходной коллекции обновленные и удаленные
      // а затем объединяю исходный список и обновление
      final list = await _reducedStateList(idsForExclusion).toList().then<List<Job>>(
            (list) => <Job>[
              ...list,
              ...chunk.where((e) => !e.deletionMark),
            ],
          );

      yield FeedState.pagination(
        list: list,
        filter: state.filter,
        endOfList: chunk.endOfList,
      );
    } on Object catch (err) {
      l.e('Произошла ошибка при обновлении ленты: $err');
      yield FeedState.error(
        filter: state.filter,
        list: state.list,
        message: 'An error occurred while updating the feed',
        endOfList: state.endOfList,
      );
      rethrow;
    } finally {
      yield FeedState.idle(
        filter: state.filter,
        list: state.list,
        endOfList: state.endOfList,
      );
    }
  }

  Stream<FeedState> _setFilter(JobFilter newFilter) => Stream<FeedState>.value(
        newFilter != state.filter
            ? FeedState.idle(
                filter: newFilter.copyWith(
                  limit: math.min(newFilter.limit, 100),
                ),
                list: <Job>[],
                endOfList: false,
              )
            : FeedState.idle(
                filter: state.filter,
                list: state.list,
                endOfList: state.endOfList,
              ),
      );

  /// Исключаю из исходной коллекции элементы
  Stream<Job> _reducedStateList(List<String> idsForExclusion) async* {
    if (idsForExclusion.isEmpty || state.list.isEmpty) return;
    final ids = List<String>.of(idsForExclusion);
    final sw = Stopwatch()..start();
    for (final job in state.list) {
      for (final id in ids) {
        if (job.id == id) {
          ids.remove(id);
        } else {
          yield job;
        }
        if (sw.elapsedMilliseconds > 8) {
          await Future<void>.delayed(Duration.zero);
          sw.reset();
        }
      }
    }
    sw.stop();
  }
}
