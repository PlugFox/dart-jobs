import 'dart:async';

import 'package:dart_jobs_client/src/feature/authentication/bloc/authentication_bloc.dart';
import 'package:dart_jobs_client/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class AuthenticationScope extends StatefulWidget {
  final Widget child;
  const AuthenticationScope({
    required this.child,
    final Key? key,
  }) : super(key: key);

  /// Find _AuthenticationScopeState in BuildContext
  static _AuthenticationScopeState? _of(final BuildContext context, {bool listen = false}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_InheritedAuthentication>()?.state;
    } else {
      final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedAuthentication>()?.widget;
      return inheritedWidget is _InheritedAuthentication ? inheritedWidget.state : null;
    }
  }

  /// Получить пользователя из контекста
  static UserEntity userOf(final BuildContext context, {bool listen = false}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_InheritedAuthentication>()?.userEntity ??
          const UserEntity.notAuthenticated();
    } else {
      final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedAuthentication>()?.widget;
      return inheritedWidget is _InheritedAuthentication
          ? inheritedWidget.userEntity
          : const UserEntity.notAuthenticated();
    }
  }

  /// Проверить, совпадает ли идентификатор с текущим пользователем
  static bool isSameUid(final BuildContext context, final String uid, {bool listen = false}) => userOf(
        context,
        listen: listen,
      ).when<bool>(
        authenticated: (final user) => user.uid == uid,
        notAuthenticated: () => false,
      );

  /// Проверить, авторизован ли текущий пользователь
  static bool isAuthenticatedOf(final BuildContext context, {bool listen = false}) => userOf(
        context,
        listen: listen,
      ).isAuthenticated;

  /// Получить авторизованного пользователя из контекста или null
  static AuthenticatedUser? authenticatedOrNullOf(final BuildContext context, {bool listen = false}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_InheritedAuthentication>()?.userEntity.authenticatedOrNull;
    } else {
      final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedAuthentication>()?.widget;
      return inheritedWidget is _InheritedAuthentication ? inheritedWidget.userEntity.authenticatedOrNull : null;
    }
  }

  /// Выполнить коллбэк если аутентифицированы
  /// Войти с помощью гугла если не вошли
  /// Если аутентифицировались в течении 5 секунд - также выполняем коллбэк
  /// !!! Внимание, внутри коллбэка нельзя использовать контекст и любые зависимости,
  ///   которые перестанут быть актуальными к моменту его выполнения !!!
  static void authenticateOr(
    final BuildContext context,
    final void Function(AuthenticatedUser user) callback,
  ) {
    final user = userOf(context, listen: false);
    if (user is AuthenticatedUser) {
      callback(user);
    } else {
      _of(context, listen: false)
          ?.bloc
          .stream
          .map<UserEntity>((final state) => state.user)
          .timeout(
            const Duration(seconds: 5),
            onTimeout: (final sink) {},
          )
          .firstWhere(
        (final user) {
          if (user is! AuthenticatedUser) {
            return false;
          }
          callback(user);
          return true;
        },
      );
      signIn(context);
    }
  }

  /// Отобразить диалог входа
  static void signIn(final BuildContext context) => signInWithGoogle(context);

  /// Войти с помощью гугла
  static void signInWithGoogle(final BuildContext context) =>
      _of(context, listen: false)?.bloc.add(const AuthenticationEvent.signInWithGoogle());

  /// Разлогиниться
  static void logOut(final BuildContext context) =>
      _of(context, listen: false)?.bloc.add(const AuthenticationEvent.logOut());

  @override
  State<AuthenticationScope> createState() => _AuthenticationScopeState();
}

class _AuthenticationScopeState extends State<AuthenticationScope> {
  late AuthenticationBLoC bloc;
  FirebaseAnalytics? _analytics;
  StreamSubscription<AuthenticationState>? _subscription;

  @override
  void initState() {
    super.initState();
    bloc = AuthenticationBLoC(
      authenticationRepository: RepositoryScope.of(context).authenticationRepository,
    );
    _analytics = RepositoryScope.of(context).analytics;
    _subscription = bloc.stream.listen(_onStateChanged, cancelOnError: false);
    _onStateChanged(bloc.state);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    bloc.close();
    super.dispose();
  }

  void _onStateChanged(final AuthenticationState state) => state.maybeMap<void>(
        orElse: () {},
        authenticated: (final state) {
          //final user = state.user;
          Future<void>.delayed(
            const Duration(seconds: 1),
            () => _analytics?.logLogin(loginMethod: state.loginMethod),
          );
        },
      );

  @override
  Widget build(final BuildContext context) => BlocProvider<AuthenticationBLoC>.value(
        value: bloc,
        child: BlocBuilder<AuthenticationBLoC, AuthenticationState>(
          bloc: bloc,
          builder: (final context, final state) => _InheritedAuthentication(
            state: this,
            userEntity: state.user,
            child: widget.child,
          ),
        ),
      );
}

@immutable
class _InheritedAuthentication extends InheritedWidget {
  final _AuthenticationScopeState state;
  final UserEntity userEntity;

  const _InheritedAuthentication({
    required final this.state,
    required final this.userEntity,
    required final Widget child,
    final Key? key,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(final _InheritedAuthentication oldWidget) => userEntity != oldWidget.userEntity;
}
