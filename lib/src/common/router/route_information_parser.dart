import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'configuration.dart';

class AppRouteInformationParser implements RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    final location = routeInformation.location ?? '/';
    final uri = Uri.parse(location);
    final configuration = uriToRouteConfiguration(uri);
    return SynchronousFuture<RouteConfiguration>(configuration);
  }

  @override
  RouteInformation? restoreRouteInformation(RouteConfiguration configuration) {
    final uri = configuration.toUri();
    final location = uri.toString();
    return RouteInformation(location: location);
  }

  static RouteConfiguration uriToRouteConfiguration(Uri uri) {
    final path = uri.pathSegments;
    switch (path.firstOrNull) {
      case 'profile':
        return ProfileRouteConfiguration();
      case 'settings':
        return SettingsRouteConfiguration();
      case 'job':
        final id = path.length > 1 ? path[1] : '';
        if (id.isEmpty) break;
        return JobRouteConfiguration(id: id);
      case '':
      case '/':
      case 'feed':
      case null:
      default:
        break;
    }
    return FeedRouteConfiguration();
  }
}
