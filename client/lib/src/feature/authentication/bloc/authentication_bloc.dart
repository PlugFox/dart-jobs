import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_jobs_client/src/feature/authentication/data/authentication_repository.dart';
import 'package:dart_jobs_client/src/feature/authentication/model/user_entity.dart';
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

  AuthenticationBLoC({
    required final IAuthenticationRepository authenticationRepository,
    final AuthenticationState? initialState,
  })  : _authenticationRepository = authenticationRepository,
        super(initialState ?? AuthenticationState.fromUser(authenticationRepository.currentUser)) {
    _authStateChangesSubscription = authenticationRepository.authStateChanges
        .map<AuthenticationState>(AuthenticationState.fromUser)
        // ignore: invalid_use_of_visible_for_testing_member
        .listen(emit, cancelOnError: false);
    on<_SignInWithGoogleEvent>((event, emit) => _signInWithGoogle(emit));
    on<_LogOutEvent>((event, emit) => _logOut(emit));
  }

  final IAuthenticationRepository _authenticationRepository;
  StreamSubscription<void>? _authStateChangesSubscription;

  Future<void> _signInWithGoogle(Emitter emit) async {
    if (state.isAuthenticated) return;
    l.vvvvvv('Начат процесс аутентификации в Google');
    emit(AuthenticationState.progress(user: state.user));
    try {
      l.vvvvvv('Запросим у репозитория аутентификации аутентификацию в гугле');
      final user = await _authenticationRepository.signInWithGoogle();
      emit(AuthenticationState.fromUser(user));
    } on Object {
      l.w('Во время аутентификации в гугле произошла ошибка');
      emit(const AuthenticationState.notAuthenticated());
      rethrow;
    }
  }

  Future<void> _logOut(Emitter emit) async {
    if (state.isNotAuthenticated) return;
    l.vvvvvv('Начат процесс разлогинивания');
    emit(AuthenticationState.progress(user: state.user));
    try {
      await _authenticationRepository.logOut();
      emit(const AuthenticationState.notAuthenticated());
    } on Object {
      l.w('Во время разлогина произошла ошибка');
      emit(AuthenticationState.fromUser(state.user));
      rethrow;
    }
  }

  @override
  Future<void> close() async {
    await _authStateChangesSubscription?.cancel();
    return super.close();
  }
}
