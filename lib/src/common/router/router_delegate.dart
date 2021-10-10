// ignore_for_file: prefer_mixin, avoid_types_on_closure_parameters
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l/l.dart';
import 'package:platform_info/platform_info.dart';

import '../../feature/initialization/widget/initialization_scope.dart';
import '../../feature/not_found/widget/not_found_screen.dart';
import 'configuration.dart';
import 'page_router.dart';
import 'root_route.dart';
import 'transition_delegate.dart';

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
          if (analytics != null) FirebaseAnalyticsObserver(analytics: analytics),
        ],
        pages: configuration.buildPages(context).toList(growable: false),
        onPopPage: (Route<Object?> route, Object? result) {
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
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    l.i('PageRouter.setNewRoutePath(${configuration.toUri()})');
    _currentConfiguration = configuration;
    notifyListeners();
    return SynchronousFuture<void>(null);
  }

  Route<void> _onUnknownRoute(RouteSettings settings) => MaterialPageRoute<void>(
        settings: settings,
        builder: (context) => const NotFoundScreen(),
      );

  void _setBrowserTitle(BuildContext context) {
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
