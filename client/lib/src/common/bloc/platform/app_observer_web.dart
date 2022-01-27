import 'package:dart_jobs_client/src/common/utils/error_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';
import 'package:sentry/sentry.dart';

BlocObserver createBlocObserver() => BlocObserverWeb();

class BlocObserverWeb extends BlocObserver with _SentryTransactionMixin {
  @override
  void onCreate(BlocBase<Object?> bloc) {
    super.onCreate(bloc);
    l.vvvv('${bloc.runtimeType}()');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event == null) return;
    _startTransaction(bloc, event);
    l.vvvvv('${bloc.runtimeType}.add(${event.runtimeType})');
    final Object? state = bloc.state;
    if (state == null) return;
    _setState(bloc, state);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    final Object? event = transition.event;
    final Object? currentState = transition.currentState;
    final Object? nextState = transition.nextState;
    if (event == null || currentState == null || nextState == null) return;
    _setState(bloc, nextState);
    l.vvvvvv('${bloc.runtimeType} ${event.runtimeType}: ${currentState.runtimeType}->${nextState.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    l.e(error, stackTrace);
    ErrorUtil.logError(
      error,
      stackTrace: stackTrace,
      hint: 'BLoC: ${bloc.runtimeType.toString()}',
    );
    _finishTransaction(bloc, false);
  }

  @override
  void onClose(BlocBase<Object?> bloc) {
    super.onClose(bloc);
    _finishTransaction(bloc, true);
    l.vvvv('${bloc.runtimeType}.close()');
  }
}

mixin _SentryTransactionMixin {
  /// Sentry transactions
  final Map<BlocBase, ISentrySpan?> _transactions = <BlocBase, ISentrySpan?>{};
  final Map<BlocBase, List<Object>?> _states = <BlocBase, List<Object>?>{};

  void _startTransaction(BlocBase bloc, Object event) {
    try {
      _finishTransaction(bloc, true);
      _transactions[bloc] = Sentry.startTransaction(
        bloc.runtimeType.toString(),
        'BLoC',
        autoFinishAfter: const Duration(milliseconds: 5 * 60 * 1000),
      )
        ..setTag(
          'bloc_type',
          bloc.runtimeType.toString(),
        )
        ..setTag(
          'event_type',
          event.runtimeType.toString(),
        )
        ..setData(
          'Event',
          event.toString(),
        );
    } on Object catch (error, stackTrace) {
      l.e('Произошло исключение "$error" в _SentryTransactionMixin._startTransaction', stackTrace);
    }
  }

  void _setState(BlocBase bloc, Object state) => (_states[bloc] ??= <Object>[]).add(state);

  void _finishTransaction(BlocBase bloc, bool successful) {
    try {
      if (_transactions[bloc]?.finished ?? true) return;
      final states = _states[bloc] ?? <Object>[];
      var i = 0;
      for (final state in states) {
        _transactions[bloc]?.setData('State #$i', state.toString());
        i++;
      }
      states.clear();
      _transactions[bloc]?.finish(status: successful ? const SpanStatus.ok() : const SpanStatus.internalError());
      _transactions[bloc] = null;
      _states[bloc] = null;
    } on Object catch (error, stackTrace) {
      l.e('Произошло исключение "$error" в _SentryTransactionMixin._finishTransaction', stackTrace);
    }
  }
}
