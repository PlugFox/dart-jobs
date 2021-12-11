import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';

BlocObserver createBlocObserver() => BlocObserverWeb();

class BlocObserverWeb extends BlocObserver {
  @override
  void onChange(BlocBase<Object?> bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase<Object?> bloc) {
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase<Object?> bloc) {
    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase<Object?> bloc, Object error, StackTrace stackTrace) {
    l.w('Ошибка в блоке $bloc: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc<Object?, Object?> bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}
