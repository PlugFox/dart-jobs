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

  /// Запросить еще [count] элементов
  const factory FeedEvent.paginate({
    required final int count,
  }) = _PaginateFeedEvent;
}

@freezed
class FeedState with _$FeedState {
  const FeedState._();

  /// Выполняется обработка/загрузка ленты
  /// [list] - текущий список
  /// [loadingCount] - количество запрашиваемых элементов
  const factory FeedState.processed({
    required final List<Proposal> list,
    required final int loadingCount,
  }) = _ProcessedFeedState;

  /// Пустая лента (изначальное состояние)
  const factory FeedState.empty({
    @Default(<Proposal>[]) final List<Proposal> list,
  }) = _EmptyFeedState;

  /// Заполненная лента
  /// [list] - текущий список
  /// [endOfList] - достигнут конец списка и более старых элементов больше не будет
  const factory FeedState.idle({
    required final List<Proposal> list,
    @Default(false) final bool endOfList,
  }) = _IdleFeedState;

  /// Ошибка получения ленты
  /// [list] - текущий список
  /// [message] - описание ошибки
  const factory FeedState.error({
    required final List<Proposal> list,
    required final String message,
  }) = _ErrorFeedState;
}

class FeedBLoC extends Bloc<FeedEvent, FeedState> {
  final IFeedRepository _repository;
  FeedBLoC({
    required final IFeedRepository repository,
    FeedState initialState = const FeedState.empty(),
  })  : _repository = repository,
        super(initialState);

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) => event.when<Stream<FeedState>>(
        paginate: _paginate,
      );

  @override
  Stream<Transition<FeedEvent, FeedState>> transformEvents(
    Stream<FeedEvent> events,
    TransitionFunction<FeedEvent, FeedState> transitionFn,
  ) =>
      super.transformEvents(
        events.transform<FeedEvent>(
          StreamTransformer.fromHandlers(
            handleData: (event, sink) => event.maybeMap<void>(
              orElse: () => sink.add(event),
              paginate: (_) => state.maybeMap<void>(
                orElse: () => sink.add(event),
                // ignore: no-empty-block
                processed: (_) {},
              ),
            ),
          ),
        ),
        transitionFn,
      );

  Stream<FeedState> _paginate(final int count) async* {
    final loadingCount = math.min(count, 100);
    try {
      yield FeedState.processed(
        list: state.list,
        loadingCount: loadingCount,
      );

      final createdBefore = state.list.lastOrNull?.created ?? DateTime.now();
      final proposalsStream = _repository.paginate(count: loadingCount, createdBefore: createdBefore);
      final proposals = (await proposalsStream.toList())..sort((a, b) => b.compareTo(a));
      final endOfList = proposals.length < loadingCount;

      yield FeedState.idle(
        list: List<Proposal>.of(state.list)..addAll(proposals),
        endOfList: endOfList,
      );
    } on Object catch (err) {
      l.e('Произошла ошибка при обновлении ленты');
      yield FeedState.error(
        list: state.list,
        message: 'An error occurred while updating the feed: $err',
      );
      rethrow;
    }
  }
}
