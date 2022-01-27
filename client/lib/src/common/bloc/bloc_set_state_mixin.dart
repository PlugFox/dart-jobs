import 'package:bloc/bloc.dart' show Emittable;

mixin SetStateMixin<State extends Object?> implements Emittable<State> {
  void setState(State state) => emit(state);
}
