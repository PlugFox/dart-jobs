import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

import 'configuration.dart';

class PageInformationParser = RouteInformationParser<PageConfiguration>
    with _RestoreRouteInformationMixin, _ParseRouteInformationMixin;

mixin _RestoreRouteInformationMixin on RouteInformationParser<PageConfiguration> {
  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    try {
      final uri = configuration.toUri();
      final location = uri.toString();
      return RouteInformation(location: location, state: configuration.state);
    } on Object catch (error) {
      l.e('Ошибка навигации restoreRouteInformation: $error');
      return const RouteInformation(location: '/');
    }
  }
}

mixin _ParseRouteInformationMixin on RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    try {
      final location = routeInformation.location ?? '/';
      final uri = Uri.parse(location);
      final routeInformationState = routeInformation.state;
      final state = <String, Object?>{if (routeInformationState is Map<String, Object?>) ...routeInformationState};
      final configuration = _uriToConfiguration(uri, state);
      return SynchronousFuture<PageConfiguration>(configuration);
    } on Object catch (error) {
      l.e('Ошибка навигации parseRouteInformation: $error');
      return SynchronousFuture<PageConfiguration>(const NotFoundPageConfiguration());
    }
  }

  static PageConfiguration _uriToConfiguration(Uri uri, Map<String, Object?> state) {
    final path = uri.pathSegments;
    switch (path.firstOrNull) {
      case 'auth':
      case 'login':
      case 'enter':
      case 'log_in':
      case 'settings':
        return const SettingsPageConfiguration();
      case 'user':
      case 'profile':
        return const ProfilePageConfiguration();
      case 'job':
      case 'jobs':
        return _uriToJob(uri, state);
      case 'proposal':
      case 'proposals':
      case 'items':
      case '/':
      case '*':
      case '.':
      case '':
      case null:
        if (path.length < 2) {
          return const FeedPageConfiguration();
        }
        break;
      case 'item':
      case 'feed':
      case 'not_found':
      default:
        break;
    }
    return const NotFoundPageConfiguration();
  }

  static PageConfiguration _uriToJob(Uri uri, Map<String, Object?> state) {
    final path = uri.pathSegments;
    final segment = path.skip(1).firstOrNull;
    if (segment != null && segment.length > 2 && segment.startsWith('id')) {
      final id = segment.substring(2);
      return JobPageConfiguration(id: id);
    }
    return const FeedPageConfiguration();
  }
}
