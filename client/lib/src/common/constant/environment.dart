/// Использовать fake значения
/// --dart-define=fake=true
const bool kFake = bool.fromEnvironment(
  'fake',
  defaultValue: false,
);

/// Эндпоинт графкл
const String kGraphQLEndpoint = String.fromEnvironment(
  'graphql',
  defaultValue: 'https://job.api.plugfox.dev/v1/graphql',
);
