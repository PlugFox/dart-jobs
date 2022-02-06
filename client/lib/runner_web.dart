// ignore_for_file: unnecessary_lambdas
import 'dart:html' as html;

import 'package:dart_jobs_client/src/app.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Запуск для веба
Future<void> run() {
  setUrlStrategy(const HashUrlStrategy());

  // Инициализировать и запустить приложение
  return App.initializeAndRun(
    onSuccessfulInitialization: (_) {
      html.document.getElementsByClassName('loading').toList(growable: false).forEach((element) => element.remove());
    },
  );
}
