import 'dart:async';

import 'package:dart_jobs_client/runner_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'package:dart_jobs_client/runner_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:dart_jobs_client/runner_web.dart' as runner;
import 'package:dart_jobs_client/src/common/bloc/app_bloc_observer.dart';
import 'package:dart_jobs_client/src/common/utils/error_util.dart';
import 'package:dart_jobs_client/src/common/utils/firebase_initializer.dart';
import 'package:dart_jobs_client/src/common/utils/sentry_wrapper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart' show FlutterError, kReleaseMode;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:l/l.dart';

/// Entry point
void main() => l.capture<void>(
      () => SentryUtil.wrap(_appRunner),
      const LogOptions(
        outputInRelease: bool.fromEnvironment(
          'show_logs',
          defaultValue: false,
        ),
        messageFormatting: _messageFormatting,
        handlePrint: true,
      ),
    );

/// Universal router for platform specific entry point
Future<void> _appRunner() async {
  // Запуск таймера
  final stopwatchBeforeRunApp = Stopwatch()..start();

  // Логировать все ошибки флатера
  if (kReleaseMode) {
    final sourceFlutterError = FlutterError.onError;
    FlutterError.onError = (final details) {
      l.w(details.exceptionAsString(), details.stack);
      sourceFlutterError?.call(details);
    };
  }

  // Отложенная инициализация
  WidgetsFlutterBinding.ensureInitialized();
  final ensureInitializedMs = stopwatchBeforeRunApp.elapsedMilliseconds;

  // Инициализируем фаербейз
  await FirebaseInitializer.initialize();
  final firebaseMs =
      stopwatchBeforeRunApp.elapsedMilliseconds - ensureInitializedMs;

  // Запуск приложения в зависимости от платформы
  await AppBlocObserver.runZoned(runner.run);

  final elapsedMilliseconds =
      (stopwatchBeforeRunApp..stop()).elapsedMilliseconds;

  if (elapsedMilliseconds > 2000) {
    final initMessage =
        'Инициализация приложения продлилась дольше предполагаемого: '
        '${stopwatchBeforeRunApp.elapsedMilliseconds} мс\n'
        'Отложенная инициализация заняла: $ensureInitializedMs мс\n'
        'Инициализация Firebase заняла: $firebaseMs мс';
    l.w(initMessage);
    // ignore: unawaited_futures
    FirebaseAnalytics.instance.logEvent(
      name: 'long_initialization',
      parameters: <String, Object>{'duration': elapsedMilliseconds},
    );
    ErrorUtil.logMessage(
      'Long Initialization',
      hint: initMessage,
      warning: false,
    );
  }
}

/// Logs message formatting
Object _messageFormatting(Object message, LogLevel logLevel, DateTime dt) =>
    '${dt.hour.toString().padLeft(2, '0')}:'
    '${dt.minute.toString().padLeft(2, '0')}:'
    '${dt.second.toString().padLeft(2, '0')} '
    '$message';
