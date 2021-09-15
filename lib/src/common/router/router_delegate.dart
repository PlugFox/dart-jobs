// ignore_for_file: prefer_mixin, avoid_types_on_closure_parameters
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../feature/authentication/widget/profile_page.dart';
import '../../feature/feed/widget/feed_page.dart';
import '../../feature/job/widget/job_page.dart';
import '../../feature/settings/widget/settings_page.dart';
import 'configuration.dart';
import 'root_route.dart';

class AppRouterDelegate extends RouterDelegate<RouteConfiguration> with ChangeNotifier {
  AppRouterDelegate({
    required final RouteConfiguration initialConfiguration,
  })  : _currentConfiguration = initialConfiguration,
        _navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) {
    final conf = currentConfiguration;
    return Navigator(
      key: _navigatorKey,
      transitionDelegate: const DefaultTransitionDelegate<Object?>(),
      pages: <Page<Object?>>[
        const FeedPage(),
        /*
          if (_selectedBook != null) BookDetailsPage(book: _selectedBook)
          */
        if (conf is ProfileRouteConfiguration) const ProfilePage(),
        if (conf is SettingsRouteConfiguration) const SettingsPage(),
        if (conf is JobRouteConfiguration) conf.creation ? const JobPage.create() : JobPage(id: conf.id),
      ],
      onPopPage: (Route<Object?> route, Object? result) {
        if (route is RootRoute || !route.didPop(result)) {
          return false;
        }
        _currentConfiguration = FeedRouteConfiguration();
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) {
    _currentConfiguration = configuration;
    notifyListeners();
    return SynchronousFuture(null);
  }

  @override
  RouteConfiguration get currentConfiguration => _currentConfiguration;
  RouteConfiguration _currentConfiguration;

  @override
  Future<void> setInitialRoutePath(RouteConfiguration configuration) => setNewRoutePath(configuration);

  @override
  Future<void> setRestoredRoutePath(RouteConfiguration configuration) => setNewRoutePath(configuration);

  @override
  Future<bool> popRoute() async {
    final navigator = _navigatorKey.currentState;
    if (navigator == null) return SynchronousFuture<bool>(false);
    return navigator.maybePop();
  }
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
