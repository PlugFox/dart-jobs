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
  /// Идентификатор работы
  final String id;

  /// Если идентификатор пустой - создание новой работы
  bool get creation => id.isEmpty;

  JobRouteConfiguration({required final this.id});

  JobRouteConfiguration.create() : id = '';

  @override
  Uri toUri() => Uri.parse('/job?${creation ? 'creation' : 'id=$id'}');
}
