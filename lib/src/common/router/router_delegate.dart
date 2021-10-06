// ignore_for_file: prefer_mixin, avoid_types_on_closure_parameters
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../feature/initialization/widget/initialization_scope.dart';
import '../../feature/not_found/widget/not_found_screen.dart';
import 'configuration.dart';
import 'page_router.dart';
import 'root_route.dart';

class PageObserver extends RouteObserver<PageRoute<Object?>> implements NavigatorObserver {}

class PageRouterDelegate extends RouterDelegate<PageConfiguration> with ChangeNotifier {
  PageRouterDelegate({
    final PageConfiguration initialConfiguration = const FeedPageConfiguration(),
  })  : _currentConfiguration = initialConfiguration,
        pageObserver = PageObserver();

  final PageObserver pageObserver;

  @override
  PageConfiguration get currentConfiguration => _currentConfiguration;
  PageConfiguration _currentConfiguration;

  @override
  Widget build(BuildContext context) {
    final configuration = currentConfiguration;
    final analytics = InitializationScope.storeOf(context).analytics;
    return PageRouter(
      routerDelegate: this,
      child: Navigator(
        transitionDelegate: const DefaultTransitionDelegate<Object?>(),
        onUnknownRoute: _onUnknownRoute,
        reportsRouteUpdateToEngine: true,
        observers: <NavigatorObserver>[
          pageObserver,
          if (analytics != null) FirebaseAnalyticsObserver(analytics: analytics),
        ],
        pages: configuration.buildPages(context).toList(growable: false),
        onPopPage: (Route<Object?> route, Object? result) {
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
    if (currentConfiguration.isRoot) return SynchronousFuture<bool>(false);
    final navigator = pageObserver.navigator;
    if (navigator == null) return SynchronousFuture<bool>(false);
    return navigator.maybePop();
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    _currentConfiguration = configuration;
    notifyListeners();
    return SynchronousFuture(null);
  }

  Route<void> _onUnknownRoute(RouteSettings settings) => MaterialPageRoute<void>(
        settings: settings,
        builder: (context) => const NotFoundScreen(),
      );
}

/*
class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) sync* {
    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      yield pageRoute;
    }

    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }

      yield exitingPageRoute;
    }
  }
}
*/
