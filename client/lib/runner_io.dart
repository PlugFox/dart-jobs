import 'dart:async';

import 'package:dart_jobs_client/src/app.dart';
import 'package:dart_jobs_client/src/feature/initialization/bloc/initialization_bloc.dart';
import 'package:dart_jobs_client/src/feature/initialization/data/initialization_helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kReleaseMode, FlutterError;
import 'package:l/l.dart';

/// Запуск приложения как io
void run() {
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

  // Устанавливаем идентификаторы и свойства пользователя
  FirebaseAuth.instance.authStateChanges().listen(
    (user) {
      FirebaseCrashlytics.instance.setUserIdentifier(user?.uid ?? '');
      FirebaseAnalytics.instance.setUserId(id: user?.uid ?? '');
      FirebaseAnalytics.instance.setUserProperty(name: 'name', value: user?.displayName);
      FirebaseAnalytics.instance.setUserProperty(name: 'email', value: user?.email);
    },
    onError: (Object error, StackTrace stackTrace) => l.w(
      'Failed set user identifier: $error',
      stackTrace,
    ),
    cancelOnError: false,
  );

  // Инициалзировать и запустить приложение
  _initAndRunApp();
}

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
