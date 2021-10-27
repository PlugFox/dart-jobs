import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:l/l.dart';

IBlocObserver createBlocObserver() => BlocObserverIO();

class BlocObserverIO implements IBlocObserver {
  @override
  void onChange(IBloc<Object?, Object?> bloc, Change change) {
    // TODO: implement onChange
  }

  @override
  void onClose(IBloc<Object?, Object?> bloc) {
    // TODO: implement onClose
  }

  @override
  void onCreate(IBloc<Object?, Object?> bloc) {
    // TODO: implement onCreate
  }

  @override
  void onError(IBloc<Object?, Object?> bloc, Object error, StackTrace stackTrace) {
    l.e('Ошибка в блоке $bloc: $error');
    try {
      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        fatal: false,
        reason: bloc.toString(),
      );
    } on Object {
      l.w('Ошибка отправки из BlocObserverIO в крашлитикс ошибки');
    }
  }

  @override
  void onEvent(IBloc<Object?, Object?> bloc, Object? event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(IBloc<Object?, Object?> bloc, Transition transition) {
    // TODO: implement onTransition
  }
}
