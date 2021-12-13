import 'package:dart_jobs_client/src/common/router/configuration.dart';
import 'package:dart_jobs_client/src/common/router/router_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

class AppRouteInformationParser = RouteInformationParser<IRouteConfiguration>
    with _RestoreRouteInformationMixin, _ParseRouteInformationMixin;

mixin _RestoreRouteInformationMixin on RouteInformationParser<IRouteConfiguration> {
  @override
  RouteInformation? restoreRouteInformation(IRouteConfiguration configuration) {
    try {
      //if (configuration == _currentConfiguration) {
      //  // Конфигурация не изменилась, не сообщаем платформе об изменениях
      //  return null;
      //}
      final location = RouteInformationUtil.normalize(configuration.location);
      final state = configuration.state;
      final route = RouteInformation(
        location: location,
        state: state,
      );
      //_currentConfiguration = configuration;
      return route;
    } on Object catch (error) {
      l.w('Ошибка навигации restoreRouteInformation: $error');
      return const RouteInformation(location: 'home/404');
    }
  }
}

mixin _ParseRouteInformationMixin on RouteInformationParser<IRouteConfiguration> {
  @override
  Future<IRouteConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    try {
      if (routeInformation is IRouteConfiguration) return SynchronousFuture<IRouteConfiguration>(routeInformation);
      final location = RouteInformationUtil.normalize(routeInformation.location);
      var state = routeInformation.state;
      if (state is! Map<String, Map<String, Object?>?>?) {
        state = null;
      }
      final configuration = DynamicRouteConfiguration(location, state);
      return SynchronousFuture<IRouteConfiguration>(configuration);
    } on Object catch (error) {
      l.w('Ошибка навигации parseRouteInformation: $error');
      return SynchronousFuture<IRouteConfiguration>(const NotFoundRouteConfiguration());
    }
  }
}
