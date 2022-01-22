import 'dart:async';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:dart_jobs_client/src/feature/job/data/job_network_data_provider.dart';
import 'package:dart_jobs_client/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';

part 'feed_bloc.freezed.dart';

@freezed
class FeedEvent with _$FeedEvent {
  const FeedEvent._();

  /// Запросить самые новые элементы
  @With<_FetchingRecentStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_SuccessfulStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory FeedEvent.fetchRecent() = _FetchRecentFeedEvent;

  /// Запросить более старых элементов
  @With<_PaginationStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_SuccessfulStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory FeedEvent.paginate() = _PaginateFeedEvent;

  /// Устанавливает новую фильтрацию
  @Implements<_JobFilterContainer>()
  @With<_SetFilterIdleStateEmitter>()
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
        orElse: () => true,
        idle: (_) => false,
      );

  /// Выполняется обработка/загрузка ленты старых записей
  /// [filter] - текущий отбор
  /// [list] - текущий список
  /// [endOfList] - достигнут конец списка и более старых элементов больше не будет
  @Implements<_InProgressFeedState>()
  const factory FeedState.fetchingRecent({
    required final JobFilter filter,
    required final List<Job> list,
    required final bool endOfList,
    @Default('Fetching recent') final String message,
  }) = _FetchingLatestFeedState;

  /// Выполняется обработка/загрузка ленты старых записей
  /// [filter] - текущий отбор
  /// [list] - текущий список
  /// [endOfList] - достигнут конец списка и более старых элементов больше не будет
  @Implements<_InProgressFeedState>()
  const factory FeedState.pagination({
    required final JobFilter filter,
    required final List<Job> list,
    required final bool endOfList,
    @Default('Pagination') final String message,
  }) = _PaginationFeedState;

  /// Заполненная лента
  /// [filter] - текущий отбор
  /// [list] - текущий список
  /// [endOfList] - достигнут конец списка и более старых элементов больше не будет
  const factory FeedState.idle({
    required final JobFilter filter,
    required final List<Job> list,
    required final bool endOfList,
    @Default('Idle') final String message,
  }) = _IdleFeedState;

  /// Успех
  const factory FeedState.successful({
    required final JobFilter filter,
    required final List<Job> list,
    required final bool endOfList,
    @Default('Successful') final String message,
  }) = _SuccessfulFeedState;

  /// Ошибка получения ленты
  /// [filter] - текущий отбор
  /// [list] - текущий список
  /// [endOfList] - достигнут конец списка и более старых элементов больше не будет
  /// [message] - описание ошибки
  const factory FeedState.error({
    required final JobFilter filter,
    required final List<Job> list,
    @Default(false) final bool endOfList,
    @Default('An error has occurred') final String message,
  }) = _ErrorFeedState;
}

class FeedBLoC extends Bloc<FeedEvent, FeedState> {
  DateTime _lastFetchRecent = DateTime.now();
  Timer? _timer;
  final IJobRepository _repository;
  FeedBLoC({
    required final IJobRepository repository,
    final FeedState initialState = const FeedState.idle(
      filter: JobFilter(),
      endOfList: false,
      list: <Job>[],
    ),
  })  : _repository = repository,
        super(initialState) {
    /// TODO: подписка на уведомления с сервера о новых элементах
    _timer = Timer.periodic(
      const Duration(minutes: 5),
      (_) {
        final now = DateTime.now();
        if (!state.isProcessed &&
            _lastFetchRecent.isBefore(
              now.subtract(
                const Duration(minutes: 3),
              ),
            )) {
          add(const FeedEvent.fetchRecent());
        }
      },
    );
    on<FeedEvent>(
      (event, emit) => event.map<Future<void>>(
        fetchRecent: (event) => _fetchRecent(event, emit),
        paginate: (event) => _paginate(event, emit),
        setFilter: (event) => _setFilter(event, emit),
      ),
      transformer: bloc_concurrency.sequential<FeedEvent>(),
    );
  }

  // ignore: long-method
  Future<void> _fetchRecent(_FetchRecentFeedEvent event, Emitter<FeedState> emit) async {
    try {
      emit(event.inProgress(state: state));

      JobsChunk chunk;
      do {
        final updatedAfter = state.list.firstOrNull?.updated ?? DateTime.now().subtract(const Duration(days: 1));
        final exclude = <int>[];
        for (final job in state.list) {
          if (!job.updated.isAtSameMomentAs(updatedAfter)) break;
          exclude.add(job.id);
        }
        chunk = await _repository
            .getRecent(
              updatedAfter: updatedAfter,
              filter: state.filter,
              exclude: exclude,
            )
            .timeout(const Duration(seconds: 15));

        if (chunk.isEmpty) {
          break;
        }

        // Список обновленных (их нужно исключить из пред идущего состояния)
        // тк они будут перемещены в начало ленты
        final idsForExclusion = List<int>.of(
          chunk
              .where(
                (e) =>
                    e.deletionMark ||
                    !e.updated.isAtSameMomentAs(e.created) ||
                    e.updated.isAtSameMomentAs(updatedAfter),
              )
              .map<int>((e) => e.id),
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

        emit(event.inProgress(state: state, list: list));

        // Считаю что это конец списка и больше не запрашиваю,
        // если количество полученных меньше чем половина запрошенных
        // этот допуск нужен для того, чтоб исключить "ошибочные записи"
      } while (chunk.length > state.filter.limit ~/ 2);
      _lastFetchRecent = DateTime.now();

      emit(event.successful(state: state));
    } on GraphQLJobException {
      emit(event.error(state: state, message: 'Network exception'));
      rethrow;
    } on Object catch (err) {
      l.e('Произошла ошибка при запросе последних элементов ленты: $err');
      emit(
        event.error(
          state: state,
          message: 'An error occurred while updating the feed',
        ),
      );
      rethrow;
    } finally {
      emit(event.idle(state: state));
    }
  }

  // ignore: long-method
  Future<void> _paginate(_PaginateFeedEvent event, Emitter<FeedState> emit) async {
    if (state.endOfList) {
      return;
    }
    try {
      emit(
        event.inProgress(
          state: state,
          endOfList: false,
        ),
      );

      final updatedBefore = state.list.lastOrNull?.updated ?? DateTime.now().add(const Duration(days: 1));
      final exclude = <int>[];
      for (final job in state.list.reversed) {
        if (!job.updated.isAtSameMomentAs(updatedBefore)) break;
        exclude.add(job.id);
      }
      final chunk = await _repository
          .paginate(
            updatedBefore: updatedBefore,
            filter: state.filter,
            exclude: exclude,
          )
          .timeout(const Duration(seconds: 15));

      // break if empty
      if (chunk.isEmpty) {
        emit(
          event.successful(
            state: state,
            endOfList: true,
          ),
        );
        return;
      }

      // Список более старых (если updatedBefore совпадает с updated исключаю из предидущего состояния эти id)
      final idsForExclusion = List<int>.of(
        chunk
            .where(
              (e) => e.updated.isAtSameMomentAs(updatedBefore),
            )
            .map<int>((e) => e.id),
      );
      await Future<void>.delayed(Duration.zero);

      // Исключаю из исходной коллекции обновленные и удаленные
      // а затем объединяю исходный список и обновление
      final list = await _reducedStateList(idsForExclusion).toList().then<List<Job>>(
            (list) => <Job>[
              ...list,
              ...chunk.where((e) => !e.deletionMark),
            ],
          );

      await Future<void>.delayed(const Duration(seconds: 10));

      emit(
        event.successful(
          state: state,
          list: list,
          endOfList: chunk.endOfList,
        ),
      );
    } on GraphQLJobException {
      emit(event.error(state: state, message: 'Network exception'));
      rethrow;
    } on Object catch (err) {
      l.e('Произошла ошибка при обновлении ленты: $err');
      emit(
        event.error(
          state: state,
          message: 'An error occurred while updating the feed',
        ),
      );
      rethrow;
    } finally {
      emit(
        event.idle(state: state),
      );
    }
  }

  Future<void> _setFilter(_SetFilterFeedEvent event, Emitter<FeedState> emit) =>
      Future<void>(() => emit(event.setNewFilter(state: state)));

  /// Исключаю из исходной коллекции элементы
  Stream<Job> _reducedStateList(List<int> idsForExclusion) async* {
    // Если исходный список пуст - нечего проверять
    if (state.list.isEmpty) return;
    // Если список на исключение пуст - возвращаем исходную коллекцию
    if (idsForExclusion.isEmpty) {
      yield* Stream<Job>.fromIterable(state.list);
      return;
    }
    // Список идентификаторов на исключение
    final ids = List<int>.of(idsForExclusion);
    final sw = Stopwatch()..start();
    for (final job in state.list) {
      // Обход обратной выборкой, right fold
      var idx = ids.length - 1;
      if (idx < -1) {
        // Если список на исключение пуст - возвращаем как есть
        yield job;
      } else {
        // Сравниваем идентификатор текущего элемента с идентификаторами на исключение
        while (idx >= 0) {
          // Ели идентификаторы совпали - исключаем идентификатор на исключение
          if (job.id == ids[idx]) {
            ids.removeAt(idx);
            break;
          }
          idx--;
        }
        // Если не один из идентификаторов не подошел - возвращаем как есть
        if (idx < 0) {
          yield job;
        }
      }
      // Если прошло больше 8 мс - уступаем другим событиям в эвент лупе
      if (sw.elapsedMilliseconds > 8) {
        await Future<void>.delayed(Duration.zero);
        sw.reset();
      }
    }
    sw.stop();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

/* Миксины для эвентов и стейтов */

/// Обработка
abstract class _InProgressFeedState {}

/// Содержание данных события установки новой фильтрации
@immutable
abstract class _JobFilterContainer {
  /// Новый фильтр
  JobFilter get newFilter;
}

/// Выпуск сообщения об успешном сканированнии акта и начале приемки
mixin _SetFilterIdleStateEmitter on FeedEvent implements _JobFilterContainer {
  /// Установить новый фильтр, если он отличается от предидущего - очищаем список
  FeedState setNewFilter({
    required final FeedState state,
    final String? message,
  }) =>
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
              message: message ?? 'Idle',
            );
}

/// Создание состояний "в обработке"
mixin _FetchingRecentStateEmitter on FeedEvent {
  /// Создание состояния "в обработке", [state] - текущее состояние
  FeedState inProgress({
    required final FeedState state,
    final List<Job>? list,
    final bool? endOfList,
    final String? message,
  }) =>
      FeedState.fetchingRecent(
        filter: state.filter,
        list: list ?? state.list,
        endOfList: endOfList ?? state.endOfList,
        message: message ?? 'Fetching recent',
      );
}

/// Создание состояний "в обработке"
mixin _PaginationStateEmitter on FeedEvent {
  /// Создание состояния "в обработке", [state] - текущее состояние
  FeedState inProgress({
    required final FeedState state,
    final List<Job>? list,
    final bool? endOfList,
    final String? message,
  }) =>
      FeedState.pagination(
        filter: state.filter,
        list: list ?? state.list,
        endOfList: endOfList ?? state.endOfList,
        message: message ?? 'Pagination',
      );
}

/// Выпуск состояния ошибки
mixin _ErrorStateEmitter on FeedEvent {
  /// Произошла ошибка
  FeedState error({
    required final FeedState state,
    final String? message,
  }) =>
      FeedState.error(
        filter: state.filter,
        list: state.list,
        endOfList: state.endOfList,
        message: message ?? 'An error has occurred',
      );
}

/// Выпуск состояния успешной обработки
mixin _SuccessfulStateEmitter on FeedEvent {
  /// Выпуск состояния успешной обработки
  FeedState successful({
    required final FeedState state,
    final List<Job>? list,
    final bool? endOfList,
    final String? message,
  }) =>
      FeedState.successful(
        filter: state.filter,
        list: list ?? state.list,
        endOfList: endOfList ?? state.endOfList,
        message: message ?? 'Successful',
      );
}

/// Состояние ожидания действий пользователя
mixin _IdleStateEmitter on FeedEvent {
  /// Состояние ожидания действий пользователя
  FeedState idle({
    required final FeedState state,
    final String? message,
  }) =>
      FeedState.idle(
        filter: state.filter,
        list: state.list,
        endOfList: state.endOfList,
        message: message ?? 'Idle',
      );
}
