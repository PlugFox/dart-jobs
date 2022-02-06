import 'dart:async';

import 'package:dart_jobs_client/src/common/widget/app_material_context.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/cloud_messaging/widget/cloud_messaging_scope.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs_client/src/feature/initialization/data/initialization_helper.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_scope.dart';
import 'package:flutter/widgets.dart';

@immutable
class App extends StatelessWidget {
  /// Инициализировать и запустить приложение
  /// Приложение запускается только после успешной инициализации
  /// Предполагается, что в это время показывается нейтивный сплэш экран
  static Future<BuildContext> initializeAndRun({
    /// Вызывается на каждом этапе прогресса инициализации
    final void Function(int progress, String message)? onProgress,

    /// Вызывается при неуспешной инициализации
    final void Function(String message, Object error, StackTrace stackTrace)? onFailureInitialization,

    /// Вызывается при успешной инициализации, после отображения первых кадров
    final void Function(RepositoryStore store)? onSuccessfulInitialization,
  }) async {
    final initializationCompleter = Completer<BuildContext>();
    final stopwatch = Stopwatch()..start();
    try {
      final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
      final initBloc = InitializationBLoC(initializationHelper: InitializationHelper())
        ..add(const InitializationEvent.initialize());
      StreamSubscription<InitializationState>? initSub;
      initSub = initBloc.stream.listen(
        (state) => state.map<void>(
          initializationInProgress: (state) {
            onProgress?.call(state.progress, state.message);
            // Инициализируется
          },
          error: (state) {
            // Произошла ошибка инициализации
            initSub?.cancel();
            initBloc.close();
            initializationCompleter.completeError(state.error, StackTrace.current);
            if (onFailureInitialization != null) {
              onFailureInitialization(state.message, state.error, state.stackTrace);
            }
          },
          initialized: (state) {
            // Инициализировано
            initSub?.cancel();
            initBloc.close();

            binding.addPostFrameCallback((_) {
              // Closes splash screen, and show the app layout.
              binding.allowFirstFrame();

              final context = binding.renderViewElement;
              if (context is BuildContext) {
                initializationCompleter.complete(context);
              } else {
                initializationCompleter.completeError(
                  UnsupportedError('No context after successful initialization'),
                  StackTrace.current,
                );
              }
            });

            // Запустить построение виджетов
            runApp(App(repositoryStore: state.result));

            if (onSuccessfulInitialization != null) {
              Future<void>.delayed(Duration.zero, () => onSuccessfulInitialization(state.result));
            }
          },
        ),
        cancelOnError: false,
        onDone: stopwatch.stop,
      );
    } on Object catch (error, stackTrace) {
      initializationCompleter.completeError(error, stackTrace);
    }
    return initializationCompleter.future;
  }

  /// Запустить построение виджетов
  static void run({
    required final RepositoryStore repositoryStore,
  }) =>
      runApp(
        App(repositoryStore: repositoryStore),
      );

  const App({
    required final RepositoryStore repositoryStore,
    final Key? key,
  })  : _repositoryStore = repositoryStore,
        super(key: key);

  final RepositoryStore _repositoryStore;

  @override
  Widget build(final BuildContext context) => RepositoryScope(
        repositoryStore: _repositoryStore,
        builder: (context) => const AuthenticationScope(
          child: CloudMessagingScope(
            child: SettingsScope(
              child: FeedScope(
                child: AppMaterialContext(),
              ),
            ),
          ),
        ),
      );
}
