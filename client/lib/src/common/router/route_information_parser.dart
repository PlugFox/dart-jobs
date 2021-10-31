import 'package:collection/collection.dart';
import 'package:dart_jobs/src/common/router/configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

class PageInformationParser = RouteInformationParser<PageConfiguration>
    with _RestoreRouteInformationMixin, _ParseRouteInformationMixin;

mixin _RestoreRouteInformationMixin on RouteInformationParser<PageConfiguration> {
  @override
  RouteInformation? restoreRouteInformation(final PageConfiguration configuration) {
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
  Future<PageConfiguration> parseRouteInformation(final RouteInformation routeInformation) {
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

  static PageConfiguration _uriToConfiguration(final Uri uri, final Map<String, Object?> state) {
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

  static PageConfiguration _uriToJob(final Uri uri, final Map<String, Object?> state) {
    final path = uri.pathSegments;
    final segment = path.skip(1).firstOrNull;
    if (segment == null || segment.isEmpty) {
      // Передана работа без идентификатора - переходим к флоу создания новой работы
      return JobCreatePageConfiguration();
    }
    var jobState = state['job'];
    if (jobState is! Map<String, Object?>) {
      jobState = <String, Object?>{};
    }
    final id = segment;
    return JobPageConfiguration(
      jobId: id,
      jobTitle: jobState['title']?.toString() ?? id,
      edit: jobState['edit'] == true,
    );
  }
}
