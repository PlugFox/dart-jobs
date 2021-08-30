import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart' show kReleaseMode, FlutterError;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:l/l.dart';

import 'runner_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'runner_web.dart' as runner;

/// Universal router for platform specific entry point
void main() => l.capture<Future<void>>(
      () async {
        // Запуск таймера
        final stopwatchBeforeRunApp = Stopwatch()..start();

        // Логировать все ошибки флатера
        if (kReleaseMode) {
          final sourceFlutterError = FlutterError.onError;
          FlutterError.onError = (details) {
            l.w(details.exceptionAsString(), details.stack);
            sourceFlutterError?.call(details);
          };
        }

        // Отложенная инициализация
        WidgetsFlutterBinding.ensureInitialized();

        // Инициализировать Firebase
        l.vvvvvv('Инициализируем Firebase');
        await firebase_core.Firebase.initializeApp().then(
          (firebaseApp) => Future.wait<void>(<Future<void>>[
            firebaseApp.setAutomaticDataCollectionEnabled(kReleaseMode),
            firebaseApp.setAutomaticResourceManagementEnabled(kReleaseMode),
          ]),
        );

        // Запуск приложения в зависимости от платформы
        runner.run();

        if ((stopwatchBeforeRunApp..stop()).elapsedMilliseconds > 150) {
          l.w('Инициализация приложения до вывода интерфейса продлилась дольше предполагаемого: '
              '${stopwatchBeforeRunApp.elapsedMilliseconds} мс');
        }
      },
    );
