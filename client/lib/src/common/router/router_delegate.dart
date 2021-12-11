// ignore_for_file: prefer_mixin, avoid_types_on_closure_parameters
import 'package:dart_jobs_client/src/common/router/page_router.dart';
import 'package:dart_jobs_client/src/common/router/root_route.dart';
import 'package:dart_jobs_client/src/common/router/transition_delegate.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_client/src/feature/not_found/widget/not_found_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l/l.dart';
import 'package:platform_info/platform_info.dart';

class PageObserver extends RouteObserver<PageRoute<Object?>> implements NavigatorObserver {}

class ModalObserver extends RouteObserver<ModalRoute<Object?>> implements NavigatorObserver {}

class PageRouterDelegate extends RouterDelegate<PageConfiguration> with ChangeNotifier {
  PageRouterDelegate({
    final PageConfiguration initialConfiguration = const FeedPageConfiguration(),
  })  : _currentConfiguration = initialConfiguration,
        pageObserver = PageObserver(),
        modalObserver = ModalObserver();

  final PageObserver pageObserver;
  final ModalObserver modalObserver;

  @override
  PageConfiguration get currentConfiguration => _currentConfiguration;
  PageConfiguration _currentConfiguration;

  @override
  Widget build(final BuildContext context) {
    final configuration = currentConfiguration;
    final analytics = RepositoryScope.of(context).analytics;
    _setBrowserTitle(context);
    return PageRouter(
      routerDelegate: this,
      child: Navigator(
        transitionDelegate:
            platform.isWeb ? const NoAnimationTransitionDelegate() : const DefaultTransitionDelegate<void>(),
        onUnknownRoute: _onUnknownRoute,
        reportsRouteUpdateToEngine: true,
        observers: <NavigatorObserver>[
          pageObserver,
          modalObserver,
          if (analytics != null) FirebaseAnalyticsObserver(analytics: analytics),
        ],
        pages: configuration.buildPages(context).toList(growable: false),
        onPopPage: (final Route<Object?> route, final Object? result) {
          l.i('PageRouter.onPopPage($route, $result)');

          /// TODO: проверить возврат значения роута
          if (configuration.isRoot || configuration.previous == null || route is RootRoute || !route.didPop(result)) {
            return false;
          }
          setNewRoutePath(configuration.previous ?? const NotFoundPageConfiguration());
          return true;
        },
      ),
    );
  }

  @override
  Future<bool> popRoute() {
    l.i('PageRouter.popRoute()');
    if (currentConfiguration.isRoot) return SynchronousFuture<bool>(false);
    final navigator = pageObserver.navigator;
    if (navigator == null) return SynchronousFuture<bool>(false);
    return navigator.maybePop();
  }

  @override
  Future<void> setNewRoutePath(final PageConfiguration configuration) {
    l.i('PageRouter.setNewRoutePath(${configuration.toUri()})');
    _currentConfiguration = configuration;
    notifyListeners();
    return SynchronousFuture<void>(null);
  }

  Route<void> _onUnknownRoute(final RouteSettings settings) => MaterialPageRoute<void>(
        settings: settings,
        builder: (final context) => const NotFoundScreen(),
      );

  void _setBrowserTitle(final BuildContext context) {
    if (kIsWeb) {
      SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
          label: currentConfiguration.pageTitle,
          primaryColor: Theme.of(context).primaryColor.value,
        ),
      );
    }
  }
}
