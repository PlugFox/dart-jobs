import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'configuration.dart';

class AppRouteInformationParser implements RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    final location = routeInformation.location ?? '/';
    final uri = Uri.parse(location);
    final path = uri.pathSegments;
    switch (path.firstOrNull) {
      case 'profile':
        return SynchronousFuture<RouteConfiguration>(ProfileRouteConfiguration());
      case 'settings':
        return SynchronousFuture<RouteConfiguration>(SettingsRouteConfiguration());
      case 'job':
        final id = path.length > 1 ? path[1] : '';
        if (id.isEmpty) break;
        return SynchronousFuture<RouteConfiguration>(
          JobRouteConfiguration(id: id),
        );
      case '':
      case '/':
      case 'feed':
      case null:
      default:
        break;
    }
    return SynchronousFuture<RouteConfiguration>(FeedRouteConfiguration());
  }

  @override
  RouteInformation? restoreRouteInformation(RouteConfiguration configuration) {
    final uri = configuration.toUri();
    final location = uri.toString();
    return RouteInformation(location: location);
  }
}
