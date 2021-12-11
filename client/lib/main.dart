import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:dart_jobs_client/runner_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'package:dart_jobs_client/runner_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:dart_jobs_client/runner_web.dart' as runner;
import 'package:dart_jobs_client/src/common/bloc/app_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart' show kReleaseMode, FlutterError;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';

/// Universal router for platform specific entry point
void main() => l.capture<Future<void>>(
      () async {
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
        await firebase_core.Firebase.initializeApp().then<void>(
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

        if ((stopwatchBeforeRunApp..stop()).elapsedMilliseconds > 250) {
          l.w(
            'Инициализация приложения до вывода интерфейса продлилась дольше предполагаемого: '
            '${stopwatchBeforeRunApp.elapsedMilliseconds} мс\n'
            'Отложенная инициализация заняла: $ensureInitializedMs мс\n'
            'Инициализация фаербейза заняла: $firebaseMs мс',
          );
        }
      },
    );
