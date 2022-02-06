import 'package:dart_jobs_client/src/app.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kReleaseMode, FlutterError;
import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

/// Запуск приложения как io
Future<void> run() {
  // Собирать логи для Crashlytics в релизе
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
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
          (final msg) => msg.level.maybeWhen<bool>(
            error: () => true,
            warning: () => true,
            orElse: () => false,
          ),
        )
        .map<String>((final msg) => msg.message.toString())
        .listen(FirebaseCrashlytics.instance.log);
  }

  // Инициализировать и запустить приложение
  return App.initializeAndRun();
}
