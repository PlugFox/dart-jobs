import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:dart_jobs_client/runner_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'package:dart_jobs_client/runner_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:dart_jobs_client/runner_web.dart' as runner;
import 'package:dart_jobs_client/src/common/bloc/app_bloc_observer.dart';
import 'package:dart_jobs_client/src/common/constant/environment.dart';
import 'package:dart_jobs_client/src/common/constant/firebase_options.dart';
import 'package:dart_jobs_client/src/common/constant/pubspec.yaml.g.dart' as pubspec;
import 'package:dart_jobs_client/src/common/utils/error_util.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart' show FlutterError, kReleaseMode;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stack_trace/stack_trace.dart' as st;

/// Entry point
void main() => l.capture<void>(
      () => _wrapSentry(_appRunner),
      const LogOptions(
        outputInRelease: bool.fromEnvironment('show_logs', defaultValue: false),
        messageFormatting: _messageFormatting,
        handlePrint: true,
      ),
    );

/// Catching all top level errors here
void _wrapSentry(AppRunner appRunner) => runZonedGuarded<Future<void>>(
      () async {
        await SentryFlutter.init(
          (options) => options
            ..dsn = 'https://eb1d8e1345ab4892aebbf4af76bb714a@sentry.plugfox.dev/1'
            ..release = pubspec.version
            ..environment = environment
            ..maxBreadcrumbs = 100
            ..attachStacktrace = true
            ..tracesSampleRate = 1
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
        ErrorUtil.logError(error, stackTrace: stackTrace, hint: 'TOP LEVEL EXCEPTION');
      },
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

  // Инициализировать Firebase
  l.vvvvvv('Инициализируем Firebase');
  await firebase_core.Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then<void>(
    (final firebaseApp) => Future.wait<void>(
      <Future<void>>[
        firebaseApp.setAutomaticDataCollectionEnabled(kReleaseMode),
        firebaseApp.setAutomaticResourceManagementEnabled(kReleaseMode),
      ],
    ),
  );
  final firebaseMs = stopwatchBeforeRunApp.elapsedMilliseconds - ensureInitializedMs;

  // Запуск приложения в зависимости от платформы
  BlocOverrides.runZoned(
    runner.run,
    blocObserver: AppBlocObserver.instance,
    eventTransformer: bloc_concurrency.sequential<Object?>(),
  );

  if ((stopwatchBeforeRunApp..stop()).elapsedMilliseconds > 2000) {
    final initMessage = 'Инициализация приложения до вывода интерфейса продлилась дольше предполагаемого: '
        '${stopwatchBeforeRunApp.elapsedMilliseconds} мс\n'
        'Отложенная инициализация заняла: $ensureInitializedMs мс\n'
        'Инициализация фаербейза заняла: $firebaseMs мс';
    l.w(initMessage);
    ErrorUtil.logMessage('Long Initialization', hint: initMessage, warning: false);
  }
}

/// Logs message formatting
Object _messageFormatting(Object message, LogLevel logLevel, DateTime dt) => '${dt.hour.toString().padLeft(2, '0')}:'
    '${dt.minute.toString().padLeft(2, '0')}:'
    '${dt.second.toString().padLeft(2, '0')} '
    '$message';

/// Logs to Sentry
void _loggerToSentryBreadcrumb() => l.listen(
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
