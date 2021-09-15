import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../../initialization/widget/initialization_scope.dart';
import '../bloc/authentication_bloc.dart';
import '../model/user_entity.dart';

@immutable
class AuthenticationScope extends StatefulWidget {
  final Widget child;
  const AuthenticationScope({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// Find _AuthenticationScopeState in BuildContext
  static _AuthenticationScopeState? _of(BuildContext context, {bool listen = false}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_InheritedAuthentication>()?.state;
    } else {
      final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedAuthentication>()?.widget;
      return inheritedWidget is _InheritedAuthentication ? inheritedWidget.state : null;
    }
  }

  /// Получить пользователя из контекста
  static UserEntity userOf(BuildContext context, {bool listen = false}) {
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

  /// Выполнить коллбэк если аутентифицированы
  /// Войти с помощью гугла если не вошли
  /// Если аутентифицировались в течении 5 секунд - также выполняем коллбэк
  static void authenticateOr(
    BuildContext context,
    void Function(AuthenticatedUser user) callback,
  ) {
    final user = userOf(context, listen: false);
    if (user is AuthenticatedUser) {
      callback(user);
    } else {
      _of(context, listen: false)
          ?.bloc
          ?.stream
          .map<UserEntity>((state) => state.user)
          .timeout(
            const Duration(seconds: 5),
            onTimeout: (sink) {},
          )
          .firstWhere(
        (user) {
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
  static void signIn(BuildContext context) => signInWithGoogle(context);

  /// Войти с помощью гугла
  static void signInWithGoogle(BuildContext context) =>
      _of(context, listen: false)?.bloc?.add(const AuthenticationEvent.signInWithGoogle());

  /// Разлогиниться
  static void logOut(BuildContext context) =>
      _of(context, listen: false)?.bloc?.add(const AuthenticationEvent.logOut());

  @override
  State<AuthenticationScope> createState() => _AuthenticationScopeState();
}

class _AuthenticationScopeState extends State<AuthenticationScope> {
  AuthenticationBLoC? bloc;

  @override
  void initState() {
    super.initState();
    bloc = AuthenticationBLoC(
      authenticationRepository: InitializationScope.storeOf(context).authenticationRepository,
    );
  }

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthenticationBLoC, AuthenticationState>(
        bloc: bloc,
        builder: (context, state) => _InheritedAuthentication(
          state: this,
          userEntity: state.user,
          child: widget.child,
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
    Key? key,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(_InheritedAuthentication oldWidget) => userEntity != oldWidget.userEntity;
}
