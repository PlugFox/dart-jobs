import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:dart_jobs_client/src/feature/bug_report/logic/bug_report_repository.dart';
import 'package:dart_jobs_client/src/feature/bug_report/model/bug_report_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';

part 'bug_report_bloc.freezed.dart';

/* События BugReportEvent */

@freezed
class BugReportEvent with _$BugReportEvent {
  const BugReportEvent._();

  @Implements<IBugReportEvent>()
  @With<_ProcessingStateEmitter>()
  @With<_SuccessfulStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory BugReportEvent.send(
    final BugReportEntity report,
  ) = _SendBugReportEvent;
}

/* Состояния BugReportState */

@freezed
class BugReportState with _$BugReportState {
  const BugReportState._();

  /// Ожидание событий, простой компонента
  bool get idling => !isProcessing;

  /// Выполняется обработка
  bool get isProcessing => maybeMap<bool>(
        orElse: () => true,
        idle: (_) => false,
      );

  /// В ожидании событий
  const factory BugReportState.idle({
    @Default('Idle') final String message,
  }) = _IdleBugReportState;

  /// Выполняется обработка
  const factory BugReportState.processing({
    @Default('Processing') final String message,
  }) = _ProcessingBugReportState;

  /// Успех
  const factory BugReportState.successful({
    required final BugReportEntity report,
    @Default('Successful') final String message,
  }) = _SuccessfulFeedState;

  /// Произошла ошибка
  const factory BugReportState.error({
    @Default('An error has occurred') final String message,
  }) = _ErrorBugReportState;
}

/* Компонент бизнес логики BugReportBLoC */

class BugReportBLoC extends Bloc<BugReportEvent, BugReportState> {
  BugReportBLoC({
    required final IBugReportRepository repository,
    final BugReportState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const BugReportState.idle(
                message: 'Initial idle state',
              ),
        ) {
    on<BugReportEvent>(
      (event, emit) => event.map<Future<void>>(
        send: (event) => _send(event, emit),
      ),
      transformer: bloc_concurrency.sequential(),
      //transformer: bloc_concurrency.restartable(),
      //transformer: bloc_concurrency.droppable(),
      //transformer: bloc_concurrency.concurrent(),
    );
  }

  final IBugReportRepository _repository;

  ///
  Future<void> _send(_SendBugReportEvent event, Emitter<BugReportState> emit) async {
    try {
      emit(event.inProgress(state: state));
      await _repository.send(event.report);
      emit(event.successful(state: state, report: event.report));
    } on Object catch (err, stackTrace) {
      l.e('В BugReportBLoC произошла ошибка: $err', stackTrace);
      emit(event.error(state: state, message: 'An error occurred'));
      rethrow;
    } finally {
      emit(event.idle(state: state));
    }
  }
}

/* Интерфейсы для эвентов BugReportEvent */

abstract class IBugReportEvent {}

/* Миксины для эвентов BugReportEvent */

/// Создание состояний "в обработке"
mixin _ProcessingStateEmitter on BugReportEvent {
  /// Создание состояния "в обработке"
  BugReportState inProgress({
    required final BugReportState state,
    final String? message,
  }) =>
      BugReportState.processing(
        message: message ?? 'Processing',
      );
}

/// Выпуск состояния успешной обработки
mixin _SuccessfulStateEmitter on BugReportEvent {
  /// Выпуск состояния успешной обработки
  BugReportState successful({
    required final BugReportState state,
    required final BugReportEntity report,
    final String? message,
  }) =>
      BugReportState.successful(
        report: report,
        message: message ?? 'Was sent successfully',
      );
}

/// Выпуск состояния ошибки
mixin _ErrorStateEmitter on BugReportEvent {
  /// Произошла ошибка
  BugReportState error({
    required final BugReportState state,
    final String? message,
  }) =>
      BugReportState.error(
        message: message ?? 'An error has occurred',
      );
}

/// Состояние ожидания действий пользователя
mixin _IdleStateEmitter on BugReportEvent {
  /// Состояние ожидания действий пользователя
  /// Простаиваем до получения события
  BugReportState idle({
    required final BugReportState state,
    final String? message,
  }) =>
      BugReportState.idle(
        message: message ?? 'Idle',
      );
}
