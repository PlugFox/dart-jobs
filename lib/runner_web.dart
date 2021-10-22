// ignore_for_file: unnecessary_lambdas
import 'dart:async';

import 'package:dart_jobs/src/app.dart';
import 'package:l/l.dart';

/// Запуск для веба
void run() =>
    // Зона перехвата всех ошибок верхнего уровня
    runZonedGuarded<void>(
      () async {
        // Запустить приложение
        App.run();
      },
      (final error, final stackTrace) {
        l.e(
          'web_top_level_error: ${error.toString()}',
          stackTrace,
        );
      },
    );
