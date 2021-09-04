abstract class RouteConfiguration {
  const RouteConfiguration();
  Uri toUri();
}

class FeedRouteConfiguration extends RouteConfiguration {
  FeedRouteConfiguration();

  @override
  Uri toUri() => Uri.parse('/');
}

class ProfileRouteConfiguration extends RouteConfiguration {
  ProfileRouteConfiguration();

  @override
  Uri toUri() => Uri.parse('/profile');
}

class SettingsRouteConfiguration extends RouteConfiguration {
  SettingsRouteConfiguration();

  @override
  Uri toUri() => Uri.parse('/settings');
}

class JobRouteConfiguration extends RouteConfiguration {
  final String id;

  JobRouteConfiguration({
    required final this.id,
  });

  @override
  Uri toUri() => Uri.parse('/job/$id');
}
