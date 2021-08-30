// ignore_for_file: prefer_mixin, avoid_types_on_closure_parameters
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../feature/home/widget/home_page.dart';
import 'configuration.dart';

class AppRouterDelegate extends RouterDelegate<AppConfiguration> with ChangeNotifier {
  AppRouterDelegate({required final AppConfiguration initialConfiguration})
      : _currentConfiguration = initialConfiguration,
        _navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) => Navigator(
        key: _navigatorKey,
        //transitionDelegate: NoAnimationTransitionDelegate(),
        pages: const <Page<Object?>>[
          HomePage(),
          /*
          MaterialPage(
            key: ValueKey('BooksListPage'),
            child: BooksListScreen(
              books: books,
              onTapped: _handleBookTapped,
            ),
          ),
          if (_selectedBook != null) BookDetailsPage(book: _selectedBook)
          */
        ],
        onPopPage: (Route<Object?> route, Object? result) {
          if (route is RootRoute) return false;
          if (!route.didPop(result)) {
            return false;
          }

          // Update the list of pages by setting _selectedBook to null
          //_selectedBook = null;
          notifyListeners();

          return true;
        },
      );

  @override
  Future<void> setNewRoutePath(AppConfiguration configuration) async {
    /*
    if (configuration.isDetailsPage) {
      _selectedBook = books[configuration.id!];
    }
    */
    _currentConfiguration = configuration;
  }

  @override
  AppConfiguration get currentConfiguration => _currentConfiguration;
  AppConfiguration _currentConfiguration;

  @override
  Future<void> setInitialRoutePath(AppConfiguration configuration) => setNewRoutePath(configuration);

  @override
  Future<void> setRestoredRoutePath(AppConfiguration configuration) => setNewRoutePath(configuration);

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
