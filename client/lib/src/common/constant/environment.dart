import 'package:platform_info/platform_info.dart';

/// Окружение, например:
/// + development
/// + integration
/// + testing
/// + staging
/// + production
String get environment => _kEnvironment.isEmpty
    ? platform.buildMode.when<String>(
        debug: () => 'development',
        profile: () => 'development',
        release: () => 'production',
      )
    : _kEnvironment;
const String _kEnvironment = String.fromEnvironment(
  'environment',
  defaultValue: '',
);

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

/// Расширенная аналитика, если это не продуктовый релиз
bool get expandedAnalytics => environment != 'production';
