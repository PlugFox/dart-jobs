// ignore_for_file: avoid-returning-widgets

import 'package:dart_jobs_client/src/common/constant/pubspec.yaml.g.dart' as pubspec;
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/configuration.dart';
import 'package:dart_jobs_client/src/common/router/navigator_observer.dart';
import 'package:dart_jobs_client/src/common/router/router_delegate.dart';
import 'package:dart_jobs_client/src/common/widget/dart_logo_icon.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

export 'package:dart_jobs_client/src/common/router/configuration.dart';

typedef NavigateCallback = IRouteConfiguration Function(IRouteConfiguration configuration);

/// Скоуп для управления роутингом и навигацией приложения
@immutable
class AppRouter extends InheritedNotifier {
  const AppRouter({
    required Widget child,
    required AppRouterDelegate routerDelegate,
    Key? key,
  })  : _routerDelegate = routerDelegate,
        super(
          key: key,
          child: child,
          notifier: routerDelegate,
        );

  final AppRouterDelegate _routerDelegate;

  AppRouterDelegate get router => _routerDelegate;

  NavigatorState? get navigator => router.pageObserver.navigator;

  @doNotStore
  static AppRouter of(BuildContext context, {bool listen = false}) {
    AppRouter? appRouter;
    if (listen) {
      appRouter = context.dependOnInheritedWidgetOfExactType<AppRouter>();
    } else {
      final inhW = context.getElementForInheritedWidgetOfExactType<AppRouter>()?.widget;
      appRouter = inhW is AppRouter ? inhW : null;
    }
    return appRouter ?? _notInScope();
  }

  @alwaysThrows
  static Never _notInScope() => throw UnsupportedError('Not in AppRouter scope');

  /// Получить навигатор из контекста
  /// См также [NavigatorState]
  static NavigatorState? navigatorOf(BuildContext context) => of(context, listen: false).navigator;

  /// Получить роутер из контекста
  /// См также [RouterDelegate]
  static AppRouterDelegate routerOf(BuildContext context) => of(context, listen: false).router;

  /// Получить обозреватель страниц из контекста
  /// См также [RouteObserver], [NavigatorObserver]
  static PageObserver pageObserverOf(BuildContext context) => of(context, listen: false).router.pageObserver;

  /// Получить обозреватель страниц из контекста
  /// См также [RouteObserver], [NavigatorObserver], [RouteAware]
  static ModalObserver modalObserverOf(BuildContext context) => of(context, listen: false).router.modalObserver;

  /// Можно ли закрыть текущий роут
  /// См также [Navigator.canPop], [ModalRoute.canPop]
  static bool canPop(BuildContext context, {bool listen = false}) =>
      listen ? (ModalRoute.of(context)?.canPop ?? false) : (navigatorOf(context)?.canPop() ?? false);

  /// Попробывать закрыть текущий роут
  /// См также [Navigator.maybePop]
  static Future<bool> maybePop<T extends Object?>(
    BuildContext context, [
    T? result,
  ]) {
    l.i('Попробуем вернуться к предидущему роуту');
    return navigatorOf(context)?.maybePop<T>(result) ?? Future<bool>.value(false);
  }

  /// Вернуться назад, а в случае неудачи - на начальный экран
  static void popOrHome(BuildContext context) => maybePop(context).then<void>(
        (value) {
          if (!value) {
            goHome(context);
          }
        },
      );

  /// Обновить конфигурацию роутера и перейти на новую страницу
  /// См также [Router.neglect], [Router.navigate]
  static void navigate(
    BuildContext context,
    NavigateCallback callback, {
    NavigateMode mode = NavigateMode.auto,
  }) {
    l.i('Обновить конфигурацию роутера');
    final delegate = of(context, listen: false).router;
    switch (mode) {
      case NavigateMode.force:
        // Перейдем на новую страницу и создадим запись в истории браузера
        Router.navigate(
          context,
          () => delegate.setNewRoutePath(
            callback(delegate.currentConfiguration),
          ),
        );
        break;
      case NavigateMode.neglect:
        // Перейдем на новую страницу без создания новой записи в истории браузера
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
  /// См также [RouterDelegate.popRoute]
  static Future<bool> pop(BuildContext context) {
    l.i('Вернемся к предидущему роуту');
    return of(context, listen: false).router.popRoute();
  }

  /// Перейти на начальную страницу
  static void goHome<T extends Object?>(
    BuildContext context, {
    NavigateMode mode = NavigateMode.neglect,
  }) =>
      navigate(
        context,
        (_) => const HomeRouteConfiguration(),
        mode: mode,
      );

  /// Получить текущие аргументы роута
  static Object? routeArguments(BuildContext context) => ModalRoute.of(context)?.settings.arguments;

  /// Содержится ли [AppRouter] в переданном контексте
  static bool containedIn(BuildContext context) => context.getElementForInheritedWidgetOfExactType<AppRouter>() != null;

  /// Добавить в навигатор анонимный экран.
  /// ВНИМАНИЕ! Для основных экранов стоит отдать предпочтение [navigate]
  /// [Navigator.push]
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder, {
    String? name,
    Object? arguments,
  }) {
    l.i('Перейдем на новый анонимный роут');
    return navigatorOf(context)?.push<T>(
          MaterialPageRoute<T>(
            builder: builder,
            settings: RouteSettings(
              name: name,
              arguments: arguments,
            ),
          ),
        ) ??
        Future<T?>.value(null);
  }

  /// Отобразить диалог от [AppRouter]
  /// См также [showDialog]
  static Future<T?> showModalDialog<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder, {
    RouteSettings? routeSettings,
  }) {
    l.i('Отобразим ModalDialog');
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
  }) {
    l.i('Отобразим ModalBottomSheet');
    return showModalBottomSheet<T>(
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

  static void showLicensePageOf(BuildContext context) => showLicensePage(
        context: navigatorOf(context)!.context,
        applicationIcon: const DartLogoIcon(),
        applicationName: context.localization.title,
        applicationVersion: pubspec.version,
        applicationLegalese: '@PlugFox',
        useRootNavigator: true,
      );
}

/// Управляет режимом навигации [AppRouter.navigate]
enum NavigateMode {
  /// Создает новую запись если URL отличается
  auto,

  /// Принудительно создает новую запись в истории браузера
  force,

  /// Принудительно не создает новую запись в истории браузера
  neglect,
}
