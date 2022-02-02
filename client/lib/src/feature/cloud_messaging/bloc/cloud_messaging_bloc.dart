import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:dart_jobs_client/src/feature/cloud_messaging/data/cloud_messaging_service.dart';
import 'package:dart_jobs_client/src/feature/cloud_messaging/model/notification_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';

part 'cloud_messaging_bloc.freezed.dart';

/* События CloudMessagingEvent */

@freezed
class CloudMessagingEvent with _$CloudMessagingEvent {
  const CloudMessagingEvent._();

  @Implements<ICloudMessagingEvent>()
  @With<_ProcessingStateEmitter>()
  @With<_SuccessfulStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory CloudMessagingEvent.check() = _CheckCloudMessagingEvent;

  @Implements<ICloudMessagingEvent>()
  @With<_ProcessingStateEmitter>()
  @With<_SuccessfulStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory CloudMessagingEvent.request({@Default(false) bool ifNotAlreadyRequested}) = _RequestCloudMessagingEvent;
}

/* Состояния CloudMessagingState */

@freezed
class CloudMessagingState with _$CloudMessagingState {
  const CloudMessagingState._();

  /// Ожидание событий, простой компонента
  bool get idling => !isProcessing;

  /// Выполняется обработка
  bool get isProcessing => maybeMap<bool>(
        orElse: () => true,
        idle: (_) => false,
      );

  bool get isSupported => status.isSupported;

  bool get isNotSupported => !isSupported;

  bool get isAuthorized => status.isAuthorized;

  bool get notAuthorized => !isAuthorized;

  /// Есть ошибка, an error has occurred
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// В ожидании событий
  const factory CloudMessagingState.idle({
    required final NotificationStatus status,
    @Default('Idle') final String message,
  }) = _IdleCloudMessagingState;

  /// Выполняется обработка
  const factory CloudMessagingState.processing({
    required final NotificationStatus status,
    @Default('Processing') final String message,
  }) = _ProcessingCloudMessagingState;

  /// Успех
  const factory CloudMessagingState.successful({
    required final NotificationStatus status,
    @Default('Successful') final String message,
  }) = _SuccessfulFeedState;

  /// Произошла ошибка
  const factory CloudMessagingState.error({
    required final NotificationStatus status,
    @Default('An error has occurred') final String message,
  }) = _ErrorCloudMessagingState;
}

/* Компонент бизнес логики CloudMessagingBLoC */

class CloudMessagingBLoC extends Bloc<CloudMessagingEvent, CloudMessagingState> {
  CloudMessagingBLoC({
    required final ICloudMessagingService service,
    final CloudMessagingState? initialState,
  })  : _service = service,
        super(
          initialState ??
              const CloudMessagingState.idle(
                status: NotificationStatus.notSupported(),
                message: 'Initial idle state',
              ),
        ) {
    on<CloudMessagingEvent>(
      (event, emit) => event.map<Future<void>>(
        check: (event) => _check(event, emit),
        request: (event) => _request(event, emit),
      ),
      transformer: bloc_concurrency.sequential(),
      //transformer: bloc_concurrency.restartable(),
      //transformer: bloc_concurrency.droppable(),
      //transformer: bloc_concurrency.concurrent(),
    );
  }

  final ICloudMessagingService _service;

  ///
  Future<void> _check(_CheckCloudMessagingEvent event, Emitter<CloudMessagingState> emit) async {
    try {
      emit(event.inProgress(state: state));
      final newStatus = await _service.check();
      emit(event.successful(state: state, newStatus: newStatus));
    } on Object catch (err, stackTrace) {
      l.e('В CloudMessagingBLoC произошла ошибка: $err', stackTrace);
      emit(event.error(state: state, message: 'An error occurred'));
      rethrow;
    } finally {
      emit(event.idle(state: state));
    }
  }

  ///
  Future<void> _request(_RequestCloudMessagingEvent event, Emitter<CloudMessagingState> emit) async {
    try {
      emit(event.inProgress(state: state));
      final newStatus = await _service.request(ifNotAlreadyRequested: event.ifNotAlreadyRequested);
      emit(event.successful(state: state, newStatus: newStatus));
    } on Object catch (err, stackTrace) {
      l.e('В CloudMessagingBLoC произошла ошибка: $err', stackTrace);
      emit(event.error(state: state, message: 'An error occurred'));
      rethrow;
    } finally {
      emit(event.idle(state: state));
    }
  }
}

/* Интерфейсы для эвентов CloudMessagingEvent */

abstract class ICloudMessagingEvent {}

/* Миксины для эвентов CloudMessagingEvent */

/// Создание состояний "в обработке"
mixin _ProcessingStateEmitter on CloudMessagingEvent {
  /// Создание состояния "в обработке"
  CloudMessagingState inProgress({
    required final CloudMessagingState state,
    final String? message,
  }) =>
      CloudMessagingState.processing(
        status: state.status,
        message: message ?? 'Processing',
      );
}

/// Выпуск состояния успешной обработки
mixin _SuccessfulStateEmitter on CloudMessagingEvent {
  /// Выпуск состояния успешной обработки
  CloudMessagingState successful({
    required final CloudMessagingState state,
    final NotificationStatus? newStatus,
    final String? message,
  }) =>
      CloudMessagingState.successful(
        status: newStatus ?? state.status,
        message: message ?? 'Successful',
      );
}

/// Выпуск состояния ошибки
mixin _ErrorStateEmitter on CloudMessagingEvent {
  /// Произошла ошибка
  CloudMessagingState error({
    required final CloudMessagingState state,
    final String? message,
  }) =>
      CloudMessagingState.error(
        status: state.status,
        message: message ?? 'An error has occurred',
      );
}

/// Состояние ожидания действий пользователя
mixin _IdleStateEmitter on CloudMessagingEvent {
  /// Состояние ожидания действий пользователя
  /// Простаиваем до получения события
  CloudMessagingState idle({
    required final CloudMessagingState state,
    final String? message,
  }) =>
      CloudMessagingState.idle(
        status: state.status,
        message: message ?? 'Idle',
      );
}
