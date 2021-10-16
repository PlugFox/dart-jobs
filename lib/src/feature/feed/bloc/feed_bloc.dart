import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';

import '../../../common/model/proposal.dart';
import '../data/feed_repository.dart';

part 'feed_bloc.freezed.dart';

@freezed
class FeedEvent with _$FeedEvent {
  const FeedEvent._();

  /// Обновить по идентификатору
  /// Если элемент не будет найден - будет удален из списка
  const factory FeedEvent.reloadById({
    required final String id,
  }) = _ReloadByIdFeedEvent;

  /// Запросить самые новые элементы
  const factory FeedEvent.fetchRecent() = _FetchRecentFeedEvent;

  /// Запросить еще [count] элементов
  const factory FeedEvent.paginate({
    required final int count,
  }) = _PaginateFeedEvent;

  /// Обработать, очистить, избавиться от дубликатов, удаленных, упорядочить список
  const factory FeedEvent.sanitize() = _SanitizeFeedEvent;
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
        fetchingLatest: (_) => true,
      );

  /// Выполняется обработка/загрузка ленты старых записей
  /// [list] - текущий список
  const factory FeedState.fetchingLatest({
    required final List<Proposal> list,
    @Default(false) final bool endOfList,
  }) = _FetchingLatestFeedState;

  /// Выполняется обработка/загрузка ленты старых записей
  /// [list] - текущий список
  /// [loadingCount] - количество запрашиваемых элементов
  const factory FeedState.pagination({
    required final List<Proposal> list,
    required final int loadingCount,
    @Default(false) final bool endOfList,
  }) = _PaginationFeedState;

  /// Заполненная лента
  /// [list] - текущий список
  /// [endOfList] - достигнут конец списка и более старых элементов больше не будет
  const factory FeedState.idle({
    @Default(<Proposal>[]) final List<Proposal> list,
    @Default(false) final bool endOfList,
  }) = _IdleFeedState;

  /// Ошибка получения ленты
  /// [list] - текущий список
  /// [message] - описание ошибки
  const factory FeedState.error({
    required final List<Proposal> list,
    required final String message,
    @Default(false) final bool endOfList,
  }) = _ErrorFeedState;
}

class FeedBLoC extends Bloc<FeedEvent, FeedState> {
  final IFeedRepository _repository;
  Timer? _fetchRecentTimer;
  FeedBLoC({
    required final IFeedRepository repository,
    FeedState initialState = const FeedState.idle(),
  })  : _repository = repository,
        super(initialState) {
    // Каждые 5 минут запрашиваем обновление на наличие новых элементов
    _fetchRecentTimer = Timer.periodic(
      const Duration(minutes: 5),
      (timer) {
        add(const FeedEvent.fetchRecent());
      },
    );
  }

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) => event.when<Stream<FeedState>>(
        reloadById: _reloadById,
        fetchRecent: _fetchRecent,
        paginate: _paginate,
        sanitize: _sanitize,
      );

  @override
  Stream<Transition<FeedEvent, FeedState>> transformEvents(
    Stream<FeedEvent> events,
    TransitionFunction<FeedEvent, FeedState> transitionFn,
  ) =>
      super.transformEvents(
        events.transform<FeedEvent>(
          StreamTransformer<FeedEvent, FeedEvent>.fromHandlers(
            handleData: (event, sink) => event.maybeMap<void>(
              orElse: () => sink.add(event),
              paginate: (_) => state.maybeMap<void>(
                orElse: () => sink.add(event),
                // ignore: no-empty-block
                pagination: (_) {},
              ),
            ),
          ),
        ),
        transitionFn,
      );

  Stream<FeedState> _reloadById(String id) async* {
    try {
      yield FeedState.fetchingLatest(
        list: state.list,
        endOfList: state.endOfList,
      );

      final proposal = await _repository.getById(id: id);
      var proposals = List<Proposal>.of(state.list);
      if (proposal == null) {
        proposals.removeWhere((p) => p.id == id);
      } else {
        proposals = await _repository.sanitize(
          <Proposal>[
            proposal,
            ...proposals,
          ],
        ).toList();
      }

      yield FeedState.idle(
        list: proposals,
        endOfList: state.endOfList,
      );
    } on Object catch (err) {
      l.e('Произошла ошибка при запросе последних элементов ленты');
      yield FeedState.error(
        list: state.list,
        message: 'An error occurred while updating the feed: $err',
        endOfList: false,
      );
      rethrow;
    }
  }

  Stream<FeedState> _fetchRecent() async* {
    try {
      yield FeedState.fetchingLatest(
        list: state.list,
        endOfList: state.endOfList,
      );

      final updatedAfter = state.list.firstOrNull?.updated ?? DateTime.now().add(const Duration(days: 1));
      final proposalsStream = _repository.fetchRecent(updatedAfter: updatedAfter);
      final newProposals = await proposalsStream.toList();
      final proposals = await _repository.sanitize(List<Proposal>.of(newProposals)..addAll(state.list)).toList();

      yield FeedState.idle(
        list: proposals,
        endOfList: state.endOfList,
      );
    } on Object catch (err) {
      l.e('Произошла ошибка при запросе последних элементов ленты');
      yield FeedState.error(
        list: state.list,
        message: 'An error occurred while updating the feed: $err',
        endOfList: false,
      );
      rethrow;
    }
  }

  Stream<FeedState> _sanitize() async* {
    try {} on Object catch (err) {
      l.e('Произошла ошибка при очистке ленты');
      yield FeedState.error(
        list: state.list,
        message: 'An error occurred while sanitizing the feed: $err',
        endOfList: false,
      );
      rethrow;
    }
  }

  Stream<FeedState> _paginate(final int count) async* {
    if (state.endOfList) {
      yield FeedState.idle(
        list: state.list,
        endOfList: true,
      );
    }
    final loadingCount = math.min(count, 100);
    try {
      yield FeedState.pagination(
        list: state.list,
        loadingCount: loadingCount,
        endOfList: false,
      );

      final updatedBefore = state.list.lastOrNull?.updated ?? DateTime.now();
      final proposalsStream = _repository.paginate(count: loadingCount, updatedBefore: updatedBefore);
      final newProposals = await proposalsStream.toList();
      final endOfList = newProposals.length < loadingCount;
      final proposals = await _repository.sanitize(List<Proposal>.of(state.list)..addAll(newProposals)).toList();

      yield FeedState.idle(
        list: proposals,
        endOfList: endOfList,
      );
    } on Object catch (err) {
      l.e('Произошла ошибка при обновлении ленты');
      yield FeedState.error(
        list: state.list,
        message: 'An error occurred while updating the feed: $err',
        endOfList: false,
      );
      rethrow;
    }
  }

  @override
  Future<void> close() {
    _fetchRecentTimer?.cancel();
    return super.close();
  }
}
