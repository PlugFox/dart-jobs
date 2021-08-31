import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';

import '../model/job.dart';
import '../model/proposal.dart';

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
  const factory FeedState.filled({
    required final List<Proposal> list,
    @Default(false) final bool endOfList,
  }) = _FilledFeedState;

  /// Ошибка получения ленты
  /// [list] - текущий список
  /// [message] - описание ошибки
  const factory FeedState.error({
    required final List<Proposal> list,
    required final String message,
  }) = _ErrorFeedState;
}

class FeedBLoC extends Bloc<FeedEvent, FeedState> {
  FeedBLoC({
    FeedState initialState = const FeedState.empty(),
  }) : super(initialState);

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) => event.when<Stream<FeedState>>(
        paginate: _paginate,
      );

  Stream<FeedState> _paginate(final int count) async* {
    final loadingCount = math.min(count, 100);
    try {
      yield FeedState.processed(
        list: state.list,
        loadingCount: loadingCount,
      );

      /// TODO: запрос
      final result = await Stream<Proposal>.periodic(
        const Duration(milliseconds: 500), // const Duration(milliseconds: 250),
        (_) => Job(
          id: DateTime.now().millisecondsSinceEpoch.toRadixString(36),
          created: DateTime.now(),
          updated: DateTime.now(),
          data: null,
        ),
      ).take(loadingCount).toList();

      yield FeedState.filled(
        list: List<Proposal>.of(state.list)..addAll(result),
        endOfList: result.length < loadingCount,
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
