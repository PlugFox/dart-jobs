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

/// Эндпоинт graphql
const String kGraphQLEndpoint = String.fromEnvironment(
  'graphql',
  defaultValue: 'https://api.dartjob.dev/v1/graphql',
);

/// Эндпоинт sentry
const String kSentryEndpoint = String.fromEnvironment(
  'sentry',
  defaultValue:
      'https://ca4fedc846d846a09bdcb7db9e643dce@o1186838.ingest.sentry.io/6306648',
);

/// Расширенная аналитика, если это не продуктовый релиз
bool get expandedAnalytics => environment != 'production';

/// Топик FCM для подписки на создание работы
const String kFCMNotificationTopicJobCreated = 'job_created';
