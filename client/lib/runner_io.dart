import 'dart:async';

import 'package:dart_jobs_client/src/app.dart';
import 'package:dart_jobs_client/src/feature/initialization/bloc/initialization_bloc.dart';
import 'package:dart_jobs_client/src/feature/initialization/data/initialization_helper.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kReleaseMode, FlutterError;
import 'package:l/l.dart';

/// Запуск приложения как io
void run() =>
    // Зона перехвата всех ошибок верхнего уровня
    runZonedGuarded<Future<void>>(
      () async {
        // Собирать логи для Crashlytics в релизе
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);

        // Сбор аналитики и ошибок
        if (kReleaseMode) {
          // Перехватывать ошибки флатера в релизе
          final sourceFlutterError = FlutterError.onError;
          FlutterError.onError = (final details) {
            FirebaseCrashlytics.instance.recordFlutterError(details);
            sourceFlutterError?.call(details);
          };

          // Все ошибки и предупреждения из логов в крашлитикс
          l
              .where(
                (final msg) => msg.level.maybeWhen(
                  error: () => true,
                  warning: () => true,
                  orElse: () => false,
                ),
              )
              .map<String>((final msg) => msg.message.toString())
              .listen(FirebaseCrashlytics.instance.log);
        }

        // Инициалзировать и запустить приложение
        _initAndRunApp();
      },
      (final error, final stackTrace) {
        l.e(
          'io_top_level_error: ${error.toString()}',
          stackTrace,
        );
        FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
          reason: 'io_top_level_error',
        );
      },
    );

void _initAndRunApp() {
  final initBloc = InitializationBLoC(initializationHelper: InitializationHelper())
    ..add(const InitializationEvent.initialize());
  StreamSubscription<InitializationState>? initSub;
  initSub = initBloc.stream.listen(
    (state) => state.map<void>(
      initializationInProgress: (state) {
        // инициализируется
      },
      error: (state) {
        // произошла ошибка инициализации
        initSub?.cancel();
        initBloc.close();
      },
      initialized: (state) {
        // инициализировано
        initSub?.cancel();
        initBloc.close();

        // Запустить приложение
        App.run(repositoryStore: state.result);
      },
    ),
  );
}

///crashlytics.setUserIdentifier("12345");
