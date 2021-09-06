import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../model/user_entity.dart';

@immutable
class AuthenticationScope extends StatefulWidget {
  final Widget child;
  const AuthenticationScope({
    required this.child,
    Key? key,
  }) : super(key: key);

  /*
  /// Find _AuthenticationScopeState in BuildContext
  static _AuthenticationScopeState? _of(BuildContext context, {bool listen = false}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_InheritedAuthentication>()?.state;
    } else {
      final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedAuthentication>()?.widget;
      return inheritedWidget is _InheritedAuthentication ? inheritedWidget.state : null;
    }
  }
  */

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

  @override
  State<AuthenticationScope> createState() => _AuthenticationScopeState();
}

class _AuthenticationScopeState extends State<AuthenticationScope> {
  @override
  Widget build(BuildContext context) => _InheritedAuthentication(
        state: this,
        userEntity: const UserEntity.notAuthenticated(),
        child: widget.child,
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
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedAuthentication oldWidget) => userEntity != oldWidget.userEntity;
}
