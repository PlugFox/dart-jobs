// ignore_for_file: unnecessary_lambdas
import 'dart:async';

import 'package:l/l.dart';

import 'src/app.dart';
import 'src/common/router/initial_route_configuration.dart';

/// Запуск для веба
void run() =>
    // Зона перехвата всех ошибок верхнего уровня
    runZonedGuarded<void>(
      () async {
        // Установить изначальную локацию
        await InitialRouteConfiguration.init();

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
