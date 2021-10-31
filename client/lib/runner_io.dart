import 'dart:async';

import 'package:dart_jobs/src/app.dart';
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

        // Запустить приложение
        App.run();
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

///crashlytics.setUserIdentifier("12345");
