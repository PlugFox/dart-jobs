import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:dart_jobs_client/src/common/bloc/bloc_set_state_mixin.dart';
import 'package:dart_jobs_client/src/feature/authentication/data/authentication_repository.dart';
import 'package:dart_jobs_client/src/feature/authentication/model/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        notAuthenticated: (_) => const NotAuthenticatedUser(),
        progress: (final state) => state.user,
        authenticated: (final state) => state.user,
        error: (final state) => state.user,
      );

  bool get isAuthenticated => user.isAuthenticated;

  bool get isNotAuthenticated => !isAuthenticated;

  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  bool get inProgress => maybeMap<bool>(orElse: () => true, authenticated: (_) => false, notAuthenticated: (_) => true);

  /// Разлогинен / Не аутентифицирован
  @literal
  const factory AuthenticationState.notAuthenticated({
    @Default(NotAuthenticatedUser()) final NotAuthenticatedUser user,
  }) = _NotAuthenticatedState;

  /// Находимся в процессе аутентификации
  const factory AuthenticationState.progress({required final UserEntity user}) = _AuthenticationInProgressState;

  /// Аутентифицирован
  factory AuthenticationState.authenticated({
    required final AuthenticatedUser user,
    final String? loginMethod,
  }) = _AuthenticatedState;

  /// Ошибка в процессе аутентификации
  const factory AuthenticationState.error({
    @Default(NotAuthenticatedUser()) final UserEntity user,
    @Default('An error occurred during authentication') final String message,
  }) = _ErrorAuthenticationState;

  @factory
  // ignore: prefer_constructors_over_static_methods, invalid_factory_method_impl
  static AuthenticationState fromUser(final UserEntity user) => user.when<AuthenticationState>(
        authenticated: (final user) => AuthenticationState.authenticated(user: user),
        notAuthenticated: () => const AuthenticationState.notAuthenticated(),
      );
}

class AuthenticationBLoC extends Bloc<AuthenticationEvent, AuthenticationState>
    with SetStateMixin<AuthenticationState> {
  AuthenticationBLoC({
    required final IAuthenticationRepository authenticationRepository,
    final AuthenticationState? initialState,
  })  : _authenticationRepository = authenticationRepository,
        super(initialState ?? AuthenticationState.fromUser(authenticationRepository.currentUser)) {
    _authStateChangesSubscription = authenticationRepository.authStateChanges
        .map<AuthenticationState>(AuthenticationState.fromUser)
        .listen(setState, cancelOnError: false);
    on<_SignInWithGoogleEvent>(
      (event, emit) => _signInWithGoogle(emit),
      transformer: bloc_concurrency.droppable(),
    );
    on<_LogOutEvent>(
      (event, emit) => _logOut(emit),
      transformer: bloc_concurrency.droppable(),
    );
  }

  final IAuthenticationRepository _authenticationRepository;
  StreamSubscription<void>? _authStateChangesSubscription;

  Future<void> _signInWithGoogle(Emitter<AuthenticationState> emit) async {
    if (state.isAuthenticated) return;
    l.vvvvvv('Начат процесс аутентификации в Google');
    emit(AuthenticationState.progress(user: state.user));
    try {
      l.vvvvvv('Запросим у репозитория аутентификации аутентификацию в гугле');
      final user = await _authenticationRepository.signInWithGoogle();
      emit(AuthenticationState.fromUser(user));
    } on FirebaseAuthException catch (error, stackTrace) {
      if (error.code == 'popup-closed-by-user') {
        l.d('Пользователь закрыл окно аутентификации');
        emit(AuthenticationState.fromUser(_authenticationRepository.currentUser));
        return;
      }
      emit(
        const AuthenticationState.error(
          message: 'An error occurred during authentication',
        ),
      );
      emit(AuthenticationState.fromUser(_authenticationRepository.currentUser));
      l.w('Во время аутентификации в гугле произошла ошибка Firebase: $error', stackTrace);
      rethrow;
    } on Object catch (error, stackTrace) {
      l.w('Во время аутентификации в гугле произошла ошибка: $error', stackTrace);
      emit(
        const AuthenticationState.error(
          message: 'An error occurred during authentication',
        ),
      );
      emit(AuthenticationState.fromUser(_authenticationRepository.currentUser));
      rethrow;
    }
  }

  Future<void> _logOut(Emitter<AuthenticationState> emit) async {
    if (state.isNotAuthenticated) return;
    l.vvvvvv('Начат процесс разлогинивания');
    emit(AuthenticationState.progress(user: state.user));
    try {
      await _authenticationRepository.logOut();
      emit(AuthenticationState.fromUser(_authenticationRepository.currentUser));
    } on Object {
      l.w('Во время разлогина произошла ошибка');
      emit(
        const AuthenticationState.error(
          message: 'An error occurred during log out',
        ),
      );
      emit(AuthenticationState.fromUser(_authenticationRepository.currentUser));
      rethrow;
    }
  }

  @override
  Future<void> close() async {
    await _authStateChangesSubscription?.cancel();
    return super.close();
  }
}
