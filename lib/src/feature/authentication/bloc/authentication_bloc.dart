import 'dart:async';

import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';

import '../data/authentication_repository.dart';
import '../model/user_entity.dart';

part 'authentication_bloc.freezed.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const AuthenticationEvent._();

  /// Войти с помощью гугла
  const factory AuthenticationEvent.signInWithGoogle() = _SignInWithGoogleEvent;

  /// Разлогиниться
  const factory AuthenticationEvent.logOut() = _LogOutEvent;
}

@freezed
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  bool get isAuthenticated => when<bool>(
        notAuthenticated: (_) => false,
        progress: (_) => false,
        authenticated: (_) => true,
      );

  bool get isNotAuthenticated => !isAuthenticated;

  /// Разлогинен / Не аутентифицирован
  const factory AuthenticationState.notAuthenticated({@Default(UserEntity.notAuthenticated()) final UserEntity user}) =
      _NotAuthenticatedState;

  /// Находимся в процессе аутентификации
  const factory AuthenticationState.progress({required final UserEntity user}) = _AuthenticationInProgressState;

  /// Аутентифицирован
  const factory AuthenticationState.authenticated({required final UserEntity user}) = _AuthenticatedState;
}

class AuthenticationBLoC extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthenticationRepository _authenticationRepository;
  StreamSubscription<UserEntity>? _authStateChangesSubscription;

  AuthenticationBLoC({
    required final IAuthenticationRepository authenticationRepository,
    final AuthenticationState initialState = const AuthenticationState.notAuthenticated(),
  })  : _authenticationRepository = authenticationRepository,
        super(initialState) {
    _authStateChangesSubscription = authenticationRepository.authStateChanges.listen(
      (user) => setState(
        user.when(
          authenticated: (user) => AuthenticationState.authenticated(user: user),
          notAuthenticated: () => const AuthenticationState.notAuthenticated(),
        ),
      ),
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) => event.when<Stream<AuthenticationState>>(
        signInWithGoogle: _signInWithGoogle,
        logOut: _logOut,
      );

  Stream<AuthenticationState> _signInWithGoogle() async* {
    if (state.isAuthenticated) return;
    l.vvvvvv('Начат процесс аутентификации в Google');
    yield AuthenticationState.progress(user: state.user);
    try {
      l.vvvvvv('Запросим у репозитория аутентификации аутентификацию в гугле');
      final user = await _authenticationRepository.signInWithGoogle();
      if (user.isNotAuthenticated) {
        yield const AuthenticationState.notAuthenticated();
        return;
      }
      yield AuthenticationState.authenticated(user: user);
    } on Object {
      l.w('Во время аутентификации в гугле произошла ошибка');
      yield const AuthenticationState.notAuthenticated();
      rethrow;
    }
  }

  Stream<AuthenticationState> _logOut() async* {
    try {
      l.vvvvvv('Начат процесс разлогинивания');
      yield AuthenticationState.progress(user: state.user);
      await _authenticationRepository.logOut();
      yield const AuthenticationState.notAuthenticated();
    } on Object {
      l.w('Во время разлогинивания произошла ошибка');
      yield AuthenticationState.authenticated(user: state.user);
      rethrow;
    }
  }

  @override
  Future<void> close() async {
    await _authStateChangesSubscription?.cancel();
    return super.close();
  }
}
