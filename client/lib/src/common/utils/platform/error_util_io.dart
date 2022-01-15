import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:meta/meta.dart';
import 'package:sentry/sentry_io.dart';

@internal
void logError(Object exception, {StackTrace? stackTrace, String? hint}) {
  Sentry.captureException(exception, stackTrace: stackTrace, hint: hint);
  FirebaseCrashlytics.instance.recordError(exception, stackTrace, reason: hint, fatal: false);
}

@internal
void logMessage(String message, {required bool warning, StackTrace? stackTrace, String? hint}) {
  Sentry.captureMessage(
    message,
    level: warning ? SentryLevel.warning : SentryLevel.info,
    hint: hint,
    params: <String>[
      if (stackTrace != null) 'StackTrace: $stackTrace',
    ],
  );
  if (warning || stackTrace != null) {
    FirebaseCrashlytics.instance.recordError(message, stackTrace ?? StackTrace.current);
  } else {
    FirebaseCrashlytics.instance.log('$message${hint != null ? '\r\n$hint' : ''}');
  }
}
