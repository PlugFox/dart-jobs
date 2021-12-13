import 'dart:ui';

import 'package:dart_jobs_client/src/common/router/router_util.dart';
import 'package:flutter/widgets.dart';

class AppInformationProvider extends PlatformRouteInformationProvider {
  AppInformationProvider({
    final RouteInformation? initialRouteInformation,
  }) : super(initialRouteInformation: initialRouteInformation ?? _getDefaultRoute());

  static RouteInformation _getDefaultRoute() {
    final route = RouteInformation(
      location: RouteInformationUtil.normalize(PlatformDispatcher.instance.defaultRouteName),
    );
    return route;
  }
}
