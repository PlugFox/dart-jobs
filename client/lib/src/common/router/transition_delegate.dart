import 'package:flutter/widgets.dart';

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  const NoAnimationTransitionDelegate() : super();

  @override
  Iterable<RouteTransitionRecord> resolve({
    required final List<RouteTransitionRecord> newPageRouteHistory,
    required final Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required final Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
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
      results.add(exitingPageRoute);
    }
    return results;
  }
}

class ReverseTransitionDelegate extends TransitionDelegate<void> {
  const ReverseTransitionDelegate() : super();

  @override
  Iterable<RouteTransitionRecord> resolve({
    required final List<RouteTransitionRecord> newPageRouteHistory,
    required final Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required final Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    void handleExitingRoute(final RouteTransitionRecord? location) {
      final exitingPageRoute = locationToExitingPageRoute[location];
      if (exitingPageRoute == null) return;
      if (exitingPageRoute.isWaitingForExitingDecision) {
        final hasPagelessRoute = pageRouteToPagelessRoutes.containsKey(exitingPageRoute);
        exitingPageRoute.markForPop(exitingPageRoute.route.currentResult);
        if (hasPagelessRoute) {
          final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute]!;
          for (final pagelessRoute in pagelessRoutes) {
            if (pagelessRoute.isWaitingForExitingDecision) {
              pagelessRoute.markForPop(pagelessRoute.route.currentResult);
            }
          }
        }
      }
      results.add(exitingPageRoute);

      handleExitingRoute(exitingPageRoute);
    }

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
      handleExitingRoute(pageRoute);
    }

    handleExitingRoute(null);

    return results;
  }
}