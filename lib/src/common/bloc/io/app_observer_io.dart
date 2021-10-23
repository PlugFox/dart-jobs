import 'package:fox_flutter_bloc/bloc.dart';

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
    // TODO: implement onError
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
