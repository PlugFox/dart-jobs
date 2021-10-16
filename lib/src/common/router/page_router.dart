// ignore_for_file: avoid-returning-widgets

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

import 'configuration.dart';
import 'router_delegate.dart';

export 'configuration.dart';

typedef NavigateCallback = PageConfiguration Function(PageConfiguration configuration);

@immutable
class PageRouter extends InheritedNotifier {
  const PageRouter({
    required Widget child,
    required PageRouterDelegate routerDelegate,
    Key? key,
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
  static PageRouter of(BuildContext context, {bool listen = false}) {
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
  static PageRouter? maybeOf(BuildContext context, {bool listen = false}) {
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
  static NavigatorState? navigatorOf(BuildContext context) => of(context, listen: false).navigator;

  /// Получить роутер из контекста
  /// [RouterDelegate]
  static PageRouterDelegate routerOf(BuildContext context) => of(context, listen: false).router;

  /// Получить обозреватель страниц из контекста
  /// [RouteObserver], [NavigatorObserver]
  static PageObserver pageObserverOf(BuildContext context) => of(context, listen: false).router.pageObserver;

  /// Получить обозреватель страниц из контекста
  /// [RouteObserver], [NavigatorObserver], [RouteAware]
  static ModalObserver modalObserverOf(BuildContext context) => of(context, listen: false).router.modalObserver;

  /// Можно ли закрыть текущий роут
  /// [Navigator.canPop], [ModalRoute.canPop]
  static bool canPop(BuildContext context, {bool listen = false}) =>
      listen ? (ModalRoute.of(context)?.canPop ?? false) : (navigatorOf(context)?.canPop() ?? false);

  /// Попробывать закрыть текущий роут
  /// [Navigator.maybePop]
  static Future<bool> maybePop<T extends Object?>(
    BuildContext context, [
    T? result,
  ]) =>
      navigatorOf(context)?.maybePop<T>(result) ?? Future<bool>.value(false);

  /// Обновить конфигурацию роутера и перейти на новую страницу
  /// [Router.neglect], [Router.navigate]
  static void navigate(BuildContext context, NavigateCallback callback, {NavigateMode mode = NavigateMode.neglect}) {
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
  static Future<bool> pop(BuildContext context) => of(context, listen: false).router.popRoute();

  /// Перейти на начальную страницу
  static void goHome<T extends Object?>(BuildContext context, {NavigateMode mode = NavigateMode.auto}) => navigate(
        context,
        (_) => const FeedPageConfiguration(),
        mode: mode,
      );

  /// Получить текущие аргументы роута
  static Object? routeArguments(BuildContext context) => ModalRoute.of(context)?.settings.arguments;

  /// Содержится ли [PageRouter] в переданном контексте
  static bool containedIn(BuildContext context) =>
      context.getElementForInheritedWidgetOfExactType<PageRouter>() != null;

  /// Добавить в навигатор анонимный экран.
  /// ВНИМАНИЕ! Для основных экранов стоит отдать предпочтение [navigate]
  /// [Navigator.push]
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder, {
    Object? arguments,
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
    BuildContext context,
    WidgetBuilder builder, {
    RouteSettings? routeSettings,
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
    required BuildContext context,
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? routeSettings,
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
