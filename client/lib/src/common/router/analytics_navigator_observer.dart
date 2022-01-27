import 'package:dart_jobs_client/src/common/router/configuration.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

const String _kUnknownScreen = 'screen';
const String _kUnknownModal = 'modal';

class AnalyticsNavigatorObserver extends RouteObserver<ModalRoute<dynamic>> {
  AnalyticsNavigatorObserver({
    required this.analytics,
  });

  final FirebaseAnalytics analytics;

  /// Последний открытый PageRoute(экран).
  PageRoute? _lastPageRoute;

  void _sendScreenView(ModalRoute<dynamic> route) {
    final String screenName;
    final String className;
    if (route is PageRoute) {
      _lastPageRoute = route;
      screenName = route.settings.name ?? _kUnknownScreen;
      if (route.settings is IRouteConfiguration) {
        className = route.settings.runtimeType.toString();
      } else if (route.settings is Page) {
        className = route.settings.runtimeType.toString();
      } else {
        className = 'Page';
      }
    } else {
      final currentPageName = _lastPageRoute?.settings.name ?? _kUnknownScreen;
      screenName = '$currentPageName:${route.settings.name ?? _kUnknownModal}';
      if (route is RawDialogRoute) {
        className = 'Dialog';
      } else if (route is PopupRoute) {
        className = 'PopupRoute';
      } else {
        className = 'Modal';
      }
    }
    l.v6('Текущий экран: $screenName');
    analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: className,
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is ModalRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is ModalRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is ModalRoute && route is ModalRoute) {
      _sendScreenView(previousRoute);
    }
  }
}
