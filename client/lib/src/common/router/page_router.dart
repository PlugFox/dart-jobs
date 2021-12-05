// ignore_for_file: avoid-returning-widgets

import 'package:dart_jobs_client/src/common/router/configuration.dart';
import 'package:dart_jobs_client/src/common/router/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

export 'package:dart_jobs_client/src/common/router/configuration.dart';

typedef NavigateCallback = PageConfiguration Function(PageConfiguration configuration);

@immutable
class PageRouter extends InheritedNotifier {
  const PageRouter({
    required final Widget child,
    required final PageRouterDelegate routerDelegate,
    final Key? key,
  })  : _routerDelegate = routerDelegate,
        super(
          key: key,
          child: child,
          notifier: routerDelegate,
        );

  final PageRouterDelegate _routerDelegate;
  PageRouterDelegate get router => _routerDelegate;
  NavigatorState? get navigator => router.pageObserver.navigator;

  /// Получить [PageRouter] из контекста
  @doNotStore
  static PageRouter of(final BuildContext context, {bool listen = false}) {
    PageRouter? pageRouter;
    if (listen) {
      pageRouter = context.dependOnInheritedWidgetOfExactType<PageRouter>();
    } else {
      final inhW = context.getElementForInheritedWidgetOfExactType<PageRouter>()?.widget;
      pageRouter = inhW is PageRouter ? inhW : null;
    }
    return pageRouter ?? _notInScope();
  }

  @alwaysThrows
  static Never _notInScope() => throw UnsupportedError('Not in PageRouter scope');

  /// Получить [PageRouter] из контекста, если не существует - null
  @doNotStore
  static PageRouter? maybeOf(final BuildContext context, {bool listen = false}) {
    PageRouter? pageRouter;
    if (listen) {
      pageRouter = context.dependOnInheritedWidgetOfExactType<PageRouter>();
    } else {
      final inhW = context.getElementForInheritedWidgetOfExactType<PageRouter>()?.widget;
      pageRouter = inhW is PageRouter ? inhW : null;
    }
    return pageRouter;
  }

  /// Получить навигатор из контекста
  /// [NavigatorState]
  static NavigatorState? navigatorOf(final BuildContext context) => of(context, listen: false).navigator;

  /// Получить роутер из контекста
  /// [RouterDelegate]
  static PageRouterDelegate routerOf(final BuildContext context) => of(context, listen: false).router;

  /// Получить обозреватель страниц из контекста
  /// [RouteObserver], [NavigatorObserver]
  static PageObserver pageObserverOf(final BuildContext context) => of(context, listen: false).router.pageObserver;

  /// Получить обозреватель страниц из контекста
  /// [RouteObserver], [NavigatorObserver], [RouteAware]
  static ModalObserver modalObserverOf(final BuildContext context) => of(context, listen: false).router.modalObserver;

  /// Можно ли закрыть текущий роут
  /// [Navigator.canPop], [ModalRoute.canPop]
  static bool canPop(final BuildContext context, {bool listen = false}) =>
      listen ? (ModalRoute.of(context)?.canPop ?? false) : (navigatorOf(context)?.canPop() ?? false);

  /// Попробывать закрыть текущий роут
  /// [Navigator.maybePop]
  static Future<bool> maybePop<T extends Object?>(
    final BuildContext context, [
    final T? result,
  ]) =>
      navigatorOf(context)?.maybePop<T>(result) ?? Future<bool>.value(false);

  /// Обновить конфигурацию роутера и перейти на новую страницу
  /// [Router.neglect], [Router.navigate]
  static void navigate(
    final BuildContext context,
    final NavigateCallback callback, {
    NavigateMode mode = NavigateMode.neglect,
  }) {
    final delegate = of(context, listen: false).router;
    switch (mode) {
      case NavigateMode.force:
        l.i('Перейдем на новую страницу и создадим запись в истории браузера');
        Router.navigate(
          context,
          () => delegate.setNewRoutePath(
            callback(delegate.currentConfiguration),
          ),
        );
        break;
      case NavigateMode.neglect:
        l.i('Перейдем на новую страницу без создания новой записи в истории браузера');
        Router.neglect(
          context,
          () => delegate.setNewRoutePath(
            callback(delegate.currentConfiguration),
          ),
        );
        break;
      case NavigateMode.auto:
      default:
        delegate.setNewRoutePath(
          callback(delegate.currentConfiguration),
        );
        break;
    }
  }

  /// Обновить конфигурацию роутера и перейти на новую страницу
  /// [RouterDelegate.popRoute]
  static Future<bool> pop(final BuildContext context) => of(context, listen: false).router.popRoute();

  /// Перейти на начальную страницу
  static void goHome<T extends Object?>(final BuildContext context, {NavigateMode mode = NavigateMode.auto}) =>
      navigate(
        context,
        (final _) => const FeedPageConfiguration(),
        mode: mode,
      );

  /// Получить текущие аргументы роута
  static Object? routeArguments(final BuildContext context) => ModalRoute.of(context)?.settings.arguments;

  /// Содержится ли [PageRouter] в переданном контексте
  static bool containedIn(final BuildContext context) =>
      context.getElementForInheritedWidgetOfExactType<PageRouter>() != null;

  /// Добавить в навигатор анонимный экран.
  /// ВНИМАНИЕ! Для основных экранов стоит отдать предпочтение [navigate]
  /// [Navigator.push]
  static Future<T?> push<T extends Object?>(
    final BuildContext context,
    final WidgetBuilder builder, {
    final Object? arguments,
  }) =>
      navigatorOf(context)?.push<T>(
        MaterialPageRoute<T>(
          builder: builder,
          settings: RouteSettings(
            arguments: arguments,
          ),
        ),
      ) ??
      Future<T?>.value(null);

  /// Отобразить диалог от [PageRouter]
  /// [showDialog]
  static Future<T?> showModalDialog<T extends Object?>(
    final BuildContext context,
    final WidgetBuilder builder, {
    final RouteSettings? routeSettings,
  }) {
    final navigator = navigatorOf(context);
    if (navigator == null) return Future<T?>.value(null);
    return showDialog<T>(
      context: navigator.context,
      builder: builder,
      useRootNavigator: false,
      routeSettings: routeSettings,
      barrierDismissible: true,
      useSafeArea: true,
      barrierColor: Colors.black54,
    );
  }

  /// Shortcut to showModalBottomSheet<T>()
  static Future<T?> showBottomSheet<T extends Object?>({
    required final BuildContext context,
    required final WidgetBuilder builder,
    final Color? backgroundColor,
    final double? elevation,
    final ShapeBorder? shape,
    final Clip? clipBehavior,
    final Color? barrierColor,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
    final RouteSettings? routeSettings,
  }) =>
      showModalBottomSheet<T>(
        context: navigatorOf(context)!.context,
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        //routeSettings: routeSettings,
      );
}

/// Управляет режимом навигации [PageRouter.navigate]
enum NavigateMode {
  /// Создает новую запись если URL отличается
  auto,

  /// Принудительно создает новую запись в истории браузера
  force,

  /// Принудительно не создает новую запись в истории браузера
  neglect,
}
