// ignore_for_file: prefer_mixin, avoid_types_on_closure_parameters
import 'package:dart_jobs_client/src/common/constant/environment.dart';
import 'package:dart_jobs_client/src/common/constant/pubspec.yaml.g.dart' as pubspec;
import 'package:dart_jobs_client/src/common/router/analytics_navigator_observer.dart';
import 'package:dart_jobs_client/src/common/router/navigator_observer.dart';
import 'package:dart_jobs_client/src/common/router/pages_builder.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/common/widget/drawer_scope.dart';
import 'package:dart_jobs_client/src/common/widget/snackbars_for_global_scope.dart';
import 'package:dart_jobs_client/src/common/widget/statuses_overlay.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_client/src/feature/not_found/widget/not_found_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:platform_info/platform_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppRouterDelegate extends RouterDelegate<IRouteConfiguration> with ChangeNotifier {
  AppRouterDelegate()
      : pageObserver = PageObserver(),
        modalObserver = ModalObserver();

  final PageObserver pageObserver;
  final ModalObserver modalObserver;

  @override
  IRouteConfiguration get currentConfiguration {
    final configuration = _currentConfiguration;
    if (configuration == null) {
      throw UnsupportedError('Изначальная конфигурация не установлена');
    }
    return configuration;
  }

  IRouteConfiguration? _currentConfiguration;

  @override
  Widget build(BuildContext context) {
    final analytics = RepositoryScope.of(context).analytics;
    final configuration = currentConfiguration;
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: AppRouter(
        routerDelegate: this,
        child: DrawerScope(
          child: SnackBarsForGlobalScope(
            child: Banner(
              message: '${pubspec.major}.${pubspec.minor}.${pubspec.patch}-alfa',
              location: BannerLocation.topEnd,
              child: StatusesOverlay(
                child: PagesBuilder(
                  configuration: configuration,
                  builder: (context, pages, child) => Navigator(
                    /// TODO: возможность отключать анимации через настройки
                    /// не только для транзишенов роутов, но и целиком для MaterialApp
                    //transitionDelegate: platform.when<TransitionDelegate<void>>(
                    //      web: () => const NoAnimationTransitionDelegate(),
                    //    ) ??
                    //    const DefaultTransitionDelegate<void>(),
                    onUnknownRoute: _onUnknownRoute,
                    reportsRouteUpdateToEngine: true,
                    observers: <NavigatorObserver>[
                      pageObserver,
                      modalObserver,
                      if (analytics != null) AnalyticsNavigatorObserver(analytics: analytics),
                      if (expandedAnalytics) SentryNavigatorObserver(),
                    ],
                    pages: pages,
                    onPopPage: (Route<Object?> route, Object? result) {
                      if (!route.didPop(result)) {
                        return false;
                      }
                      setNewRoutePath(configuration.previous ?? const NotFoundRouteConfiguration());
                      return true;
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<bool> popRoute() {
    try {
      final navigator = pageObserver.navigator;
      if (navigator == null) return SynchronousFuture<bool>(false);
      return navigator.maybePop().then<bool>(
        (value) {
          if (!value) {
            if (platform.isIO) {
              return false;
              /*
              return SystemNavigator.pop().then<bool>(
                (value) => true,
                onError: (Object error, StackTrace stackTrace) => false,
              );
              */
            }
            // В вебе, вместо перехода на главный экран, можно закрывать текущую активную вкладку
            return setNewRoutePath(
              const HomeRouteConfiguration(),
            ).then<bool>(
              (value) => true,
              onError: (Object error, StackTrace stackTrace) => false,
            );
          }
          return true;
        },
        onError: (Object error, StackTrace stackTrace) => false,
      );
    } on Object catch (err) {
      l.w('RouterDelegate.popRoute: $err');
      return SynchronousFuture(false);
    }
  }

  @override
  Future<void> setNewRoutePath(IRouteConfiguration configuration) {
    if (_currentConfiguration == configuration) {
      // Конфигурация не изменилась
      return SynchronousFuture<void>(null);
    }
    _currentConfiguration = configuration;
    notifyListeners();
    return SynchronousFuture<void>(null);
  }

  @override
  Future<void> setRestoredRoutePath(IRouteConfiguration configuration) => super.setRestoredRoutePath(configuration);

  @override
  Future<void> setInitialRoutePath(IRouteConfiguration configuration) => super.setInitialRoutePath(configuration);

  Route<void> _onUnknownRoute(RouteSettings settings) => MaterialPageRoute<void>(
        settings: settings,
        builder: (context) => const NotFoundScreen(),
      );
}
