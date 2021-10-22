import 'dart:async';

import 'package:dart_jobs/src/feature/authentication/data/authentication_repository.dart';
import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';

part 'authentication_bloc.freezed.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const AuthenticationEvent._();

  /// Войти с помощью гугла
  @literal
  const factory AuthenticationEvent.signInWithGoogle() = _SignInWithGoogleEvent;

  /// Разлогиниться
  @literal
  const factory AuthenticationEvent.logOut() = _LogOutEvent;
}

@freezed
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  UserEntity get user => super.map<UserEntity>(
        notAuthenticated: (final state) => state.user,
        progress: (final state) => state.user,
        authenticated: (final state) => state.user,
      );

  bool get isAuthenticated => user.isAuthenticated;

  bool get isNotAuthenticated => !isAuthenticated;

  /// Разлогинен / Не аутентифицирован
  @literal
  const factory AuthenticationState.notAuthenticated({@Default(UserEntity.notAuthenticated()) final UserEntity user}) =
      _NotAuthenticatedState;

  /// Находимся в процессе аутентификации
  const factory AuthenticationState.progress({required final UserEntity user}) = _AuthenticationInProgressState;

  /// Аутентифицирован
  factory AuthenticationState.authenticated({
    required final AuthenticatedUser user,
    final String? loginMethod,
  }) = _AuthenticatedState;

  @factory
  // ignore: prefer_constructors_over_static_methods, invalid_factory_method_impl
  static AuthenticationState fromUser(final UserEntity user) => user.when<AuthenticationState>(
        authenticated: (final user) => AuthenticationState.authenticated(user: user),
        notAuthenticated: () => const AuthenticationState.notAuthenticated(),
      );
}

class AuthenticationBLoC extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthenticationRepository _authenticationRepository;
  StreamSubscription<void>? _authStateChangesSubscription;

  AuthenticationBLoC({
    required final IAuthenticationRepository authenticationRepository,
    final AuthenticationState? initialState,
  })  : _authenticationRepository = authenticationRepository,
        super(initialState ?? AuthenticationState.fromUser(authenticationRepository.currentUser)) {
    _authStateChangesSubscription = authenticationRepository.authStateChanges
        .map<AuthenticationState>(AuthenticationState.fromUser)
        .listen(setState, cancelOnError: false);
  }

  @override
  Stream<AuthenticationState> mapEventToState(final AuthenticationEvent event) =>
      event.when<Stream<AuthenticationState>>(
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
      yield AuthenticationState.fromUser(user);
    } on Object {
      l.w('Во время аутентификации в гугле произошла ошибка');
      yield const AuthenticationState.notAuthenticated();
      rethrow;
    }
  }

  Stream<AuthenticationState> _logOut() async* {
    if (state.isNotAuthenticated) return;
    try {
      l.vvvvvv('Начат процесс разлогинивания');
      yield AuthenticationState.progress(user: state.user);
      await _authenticationRepository.logOut();
      yield const AuthenticationState.notAuthenticated();
    } on Object {
      l.w('Во время разлогина произошла ошибка');
      yield AuthenticationState.fromUser(state.user);
      rethrow;
    }
  }

  @override
  Future<void> close() async {
    await _authStateChangesSubscription?.cancel();
    return super.close();
  }
}
