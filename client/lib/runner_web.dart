// ignore_for_file: unnecessary_lambdas
import 'dart:async';
import 'dart:html' as html;

import 'package:dart_jobs_client/src/app.dart';
import 'package:dart_jobs_client/src/feature/initialization/bloc/initialization_bloc.dart';
import 'package:dart_jobs_client/src/feature/initialization/data/initialization_helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:l/l.dart';
import 'package:sentry/sentry.dart';

/// Запуск для веба
void run() {
  setUrlStrategy(const HashUrlStrategy());

  // Устанавливаем идентификаторы и свойства пользователя
  _onAuthStateChanges(FirebaseAuth.instance.currentUser);
  FirebaseAuth.instance.authStateChanges().listen(
        _onAuthStateChanges,
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

        // Удалить прогресс индикатор после запуска приложения
        Future<void>.delayed(
          const Duration(milliseconds: 250),
          () {
            html.document
                .getElementsByClassName('loading')
                .toList(growable: false)
                .forEach((element) => element.remove());
          },
        );

        // Запустить приложение
        App.run(repositoryStore: state.result);
      },
    ),
  );
}

void _onAuthStateChanges(User? user) {
  if (user?.uid.isNotEmpty ?? false) {
    Sentry.configureScope((scope) => scope.setTag('uid', user?.uid ?? ''));
  }
  if (user?.email?.isNotEmpty ?? false) {
    Sentry.configureScope((scope) => scope.setTag('email', user?.email ?? ''));
  }
  FirebaseAnalytics.instance.setUserId(id: user?.uid);
  FirebaseAnalytics.instance.setUserProperty(name: 'email', value: user?.email);
  FirebaseAnalytics.instance.setUserProperty(name: 'name', value: user?.displayName);
}
