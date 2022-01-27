import 'package:meta/meta.dart';
import 'package:sentry/sentry.dart';

@internal
void logError(
  Object exception, {
  StackTrace? stackTrace,
  String? hint,
}) {
  Sentry.captureException(exception, stackTrace: stackTrace, hint: hint);
}

@internal
void logMessage(
  String message, {
  required bool warning,
  StackTrace? stackTrace,
  String? hint,
  List<String>? params,
}) {
  Sentry.captureMessage(
    message,
    level: warning ? SentryLevel.warning : SentryLevel.info,
    hint: hint,
    params: <String>[
      ...?params,
      if (stackTrace != null) 'StackTrace: $stackTrace',
    ],
  );
}
