import 'package:dart_jobs/src/feature/initialization/data/initialization_helper.dart';
import 'package:dart_jobs/src/feature/initialization/model/initialization_progress.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'initialization_bloc.freezed.dart';

@freezed
class InitializationEvent with _$InitializationEvent {
  const InitializationEvent._();

  const factory InitializationEvent.initialize() = _InitializeApp;
}

@freezed
class InitializationState with _$InitializationState {
  const InitializationState._();

  bool get isInitialized => maybeMap<bool>(
        orElse: () => false,
        initialized: (final _) => true,
      );

  bool get isNotInitialized => !isInitialized;

  /// Прогресс инициализации
  /// [percent] - процент инициализации, от 0 до 100
  /// [status] - статус инициализации, сообщение о задании
  const factory InitializationState.initializationInProgress({
    required final int progress,
    required final String message,
  }) = _AppInitializationInProgress;

  /// Инициализировано
  const factory InitializationState.initialized({
    required final RepositoryStore result,
  }) = _AppInitialized;

  /// Произошла ошибка инициализации
  const factory InitializationState.error({
    required final String message,
    required final Object error,
    required final StackTrace stackTrace,
  }) = _AppInitializationError;
}

class InitializationBLoC extends Bloc<InitializationEvent, InitializationState> {
  final InitializationHelper _initializationHelper;

  InitializationBLoC({
    required final InitializationHelper initializationHelper,
    final InitializationState initialState = const InitializationState.initializationInProgress(
      progress: 0,
      message: 'Preparing for initialization',
    ),
  })  : _initializationHelper = initializationHelper,
        super(initialState);

  @override
  Stream<InitializationState> mapEventToState(final InitializationEvent event) async* {
    try {
      if (_initializationHelper.isInitialized) {
        yield InitializationState.initialized(result: _initializationHelper.getResult());
      }
      _initializationHelper.reset();
      yield* _initializationHelper.initialize().map<InitializationState>(
            (final value) => InitializationState.initializationInProgress(
              progress: value.progress,
              message: value.message,
            ),
          );
      yield InitializationState.initialized(result: _initializationHelper.getResult());
    } on Object catch (error, stackTrace) {
      // Произошла непредвиденная ошибка
      yield InitializationState.error(
        message: 'Unsupported initialization error',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
