import 'package:flutter/widgets.dart';

import 'configuration.dart';

class AppRouteInformationParser implements RouteInformationParser<AppConfiguration> {
  @override
  Future<AppConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final location = routeInformation.location;
    //final uri = Uri.parse(location);
    return AppConfiguration();
  }

  @override
  RouteInformation? restoreRouteInformation(AppConfiguration path) {
    //if (path.isHomePage) {
    //  return RouteInformation(location: '/');
    //}
    //if (path.isDetailsPage) {
    //  return RouteInformation(location: '/book/${path.id}');
    //}
    if (DateTime.now().isUtc) {
      return const RouteInformation(location: '/');
    }
    return null;
  }
}
