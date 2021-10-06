// ignore_for_file: unnecessary_lambdas
import 'dart:async';

import 'package:l/l.dart';

import 'src/app.dart';

/// Запуск для веба
void run() =>
    // Зона перехвата всех ошибок верхнего уровня
    runZonedGuarded<void>(
      () async {
        // Запустить приложение
        App.run();
      },
      (error, stackTrace) {
        l.e(
          'web_top_level_error: ${error.toString()}',
          stackTrace,
        );
      },
    );
