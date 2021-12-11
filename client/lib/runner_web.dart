// ignore_for_file: unnecessary_lambdas
import 'dart:async';

import 'package:dart_jobs_client/src/app.dart';
import 'package:dart_jobs_client/src/feature/initialization/bloc/initialization_bloc.dart';
import 'package:dart_jobs_client/src/feature/initialization/data/initialization_helper.dart';
import 'package:l/l.dart';

/// Запуск для веба
void run() =>
    // Зона перехвата всех ошибок верхнего уровня
    runZonedGuarded<void>(
      () async {
        // Инициалзировать и запустить приложение
        _initAndRunApp();
      },
      (final error, final stackTrace) {
        l.e(
          'web_top_level_error: ${error.toString()}',
          stackTrace,
        );
      },
    );

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
