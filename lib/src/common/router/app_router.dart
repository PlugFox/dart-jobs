import 'package:flutter/widgets.dart';

import 'configuration.dart';
import 'router_delegate.dart';

typedef NavigateCallback = RouteConfiguration Function(RouteConfiguration configuration);

/// Namespace, shortcut to top Router<Object>
abstract class AppRouter {
  AppRouter._();

  /// Открыть новую страницу
  static void navigate(
    BuildContext context,
    NavigateCallback callback,
  ) {
    final delegate = Router.maybeOf(context)?.routerDelegate;
    if (delegate is! AppRouterDelegate) {
      throw Exception('Не найден AppRouterDelegate в контексте');
    }
    Router.navigate(
      context,
      () => delegate.setNewRoutePath(callback(delegate.currentConfiguration)),
    );
  }

  static Future<bool> pop(BuildContext context) =>
      Router.maybeOf(context)?.routerDelegate.popRoute() ?? Future<bool>.value(false);
}
