import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

import 'configuration.dart';
import 'platform/platform_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'platform/platform_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'platform/platform_web.dart' as app_router_platform;
import 'route_information_parser.dart';

/// Класс хранящий изначальный роут (для дип линков)
class InitialRouteConfiguration {
  static InitialRouteConfiguration? _instance;
  factory InitialRouteConfiguration.instance() =>
      _instance ??
      InitialRouteConfiguration._(
        routeInformation: const RouteInformation(location: '/'),
        routeConfiguration: FeedRouteConfiguration(),
      );

  String get location => routeInformation.location ?? '/';
  final RouteInformation routeInformation;
  final RouteConfiguration routeConfiguration;
  InitialRouteConfiguration._({
    required final this.routeInformation,
    required final this.routeConfiguration,
  });

  static FutureOr<void> init() async {
    final routeInformation = RouteInformation(location: _currentLocation.split('#').last);
    l.i('* ${routeInformation.location}');
    final routeConfiguration = AppRouteInformationParser.uriToRouteConfiguration(
      Uri.parse(routeInformation.location ?? '/'),
    );
    _instance = InitialRouteConfiguration._(
      routeInformation: routeInformation,
      routeConfiguration: routeConfiguration,
    );
  }

  static String get _currentLocation => app_router_platform.getCurrentHref();
}
