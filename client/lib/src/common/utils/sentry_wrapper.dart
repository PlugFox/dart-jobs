import 'dart:async';

import 'package:dart_jobs_client/src/common/constant/environment.dart';
import 'package:dart_jobs_client/src/common/constant/pubspec.yaml.g.dart'
    as pubspec;
import 'package:dart_jobs_client/src/common/utils/error_util.dart';
import 'package:l/l.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stack_trace/stack_trace.dart' as st;

// ignore: avoid_classes_with_only_static_members
abstract class SentryUtil {
  /// Catching all top level errors here
  static void wrap(AppRunner appRunner) => runZonedGuarded<Future<void>>(
        () async {
          await SentryFlutter.init(
            (options) => options
              ..dsn = kSentryEndpoint
              ..release = pubspec.version
              ..environment = environment
              ..maxBreadcrumbs = 100
              ..attachStacktrace = true
              // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
              // We recommend adjusting this value in production.
              ..tracesSampleRate = 1.0
              ..debug = false,
          );
          _loggerToSentryBreadcrumb();
          appRunner();
        },
        (final Object error, final StackTrace stackTrace) {
          l.e(
            'TOP LEVEL EXCEPTION\r\n$error\r\n$stackTrace',
            stackTrace,
          );
          ErrorUtil.logError(
            error,
            stackTrace: stackTrace,
            hint: 'TOP LEVEL EXCEPTION',
          );
        },
      );

  /// Logs to Sentry
  static void _loggerToSentryBreadcrumb() => l.listen(
        (msg) {
          final add = msg.level.maybeWhen<bool>(
            orElse: () => false,
            error: () => true,
            shout: () => true,
            v: () => true,
            vv: () => true,
            vvv: () => true,
            info: () => true,
            debug: () => true,
            warning: () => true,
          );
          if (!add) return;
          Sentry.addBreadcrumb(
            Breadcrumb(
              message: msg.message.toString(),
              category: 'flutter.log',
              level: msg.level.when<SentryLevel>(
                shout: () => SentryLevel.info,
                v: () => SentryLevel.info,
                error: () => SentryLevel.error,
                vv: () => SentryLevel.info,
                warning: () => SentryLevel.warning,
                vvv: () => SentryLevel.info,
                info: () => SentryLevel.info,
                vvvv: () => SentryLevel.debug,
                debug: () => SentryLevel.debug,
                vvvvv: () => SentryLevel.debug,
                vvvvvv: () => SentryLevel.debug,
              ),
              timestamp: msg.date,
              data: msg is LogMessageWithStackTrace
                  ? <String, Object>{
                      'stackTrace': st.Trace.from(msg.stackTrace).toString(),
                    }
                  : null,
            ),
          );
        },
        cancelOnError: false,
      );
}


/*
import 'package:sentry/sentry.dart';

final transaction = Sentry.startTransaction('processOrderBatch()', 'task');

try {
  await processOrderBatch(transaction);
} catch (exception) {
  transaction.throwable = exception;
  transaction.status = SpanStatus.internalError();
} finally {
  await transaction.finish();
}

Future<void> processOrderBatch(ISentrySpan span) async {
  // span operation: task, span description: operation
  final innerSpan = span.startChild('task', description: 'operation');

  try {
    // omitted code
  } catch (exception) {
    innerSpan.throwable = exception;
    innerSpan.status = SpanStatus.notFound();
  } finally {
    await innerSpan.finish();
  }
}
*/
