import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/initialization_helper.dart';
import '../model/initialization_progress.dart';

part 'initialization_bloc.freezed.dart';

@freezed
class InitializationEvent with _$InitializationEvent {
  const InitializationEvent._();

  const factory InitializationEvent.initialize() = _InitializeApp;
}

@freezed
class InitializationState with _$InitializationState {
  const InitializationState._();

  const factory InitializationState.notInitialized() = _AppNotInitialized;

  const factory InitializationState.initializationInProgress({
    required final int progress,
    required final String message,
  }) = _AppInitializationInProgress;

  const factory InitializationState.initialized({
    required final RepositoryStore result,
  }) = _AppInitialized;
}

class InitializationBLoC extends Bloc<InitializationEvent, InitializationState> {
  final InitializationHelper _initializationHelper;

  InitializationBLoC({
    required final InitializationHelper initializationHelper,
    final InitializationState initialState = const InitializationState.notInitialized(),
  })  : _initializationHelper = initializationHelper,
        super(initialState);

  @override
  Stream<InitializationState> mapEventToState(InitializationEvent event) async* {
    if (_initializationHelper.isInitialized) {
      yield InitializationState.initialized(result: _initializationHelper.getResult());
    }
    _initializationHelper.reset();
    yield* _initializationHelper.initialize().map<InitializationState>(
          (value) => InitializationState.initializationInProgress(
            progress: value.progress,
            message: value.message,
          ),
        );
    yield InitializationState.initialized(result: _initializationHelper.getResult());
  }
}
