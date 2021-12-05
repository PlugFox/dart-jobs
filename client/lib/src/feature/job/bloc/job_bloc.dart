import 'dart:async';

import 'package:dart_jobs_client/src/common/model/exceptions.dart';
import 'package:dart_jobs_client/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_bloc.freezed.dart';

@freezed
class JobEvent with _$JobEvent {
  const JobEvent._();

  /// Создать новую работу
  /// Передаем данные работы
  /// Владельцем новой работы будет являться текущий пользователь
  @Implements<_JobDataContainer>()
  @With<_ProcessedStateEmitter>()
  @With<_NotFoundStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_SavedStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory JobEvent.create({required final JobData data}) = _CreateJobEvent;

  /// Запросить обновление по текущей работе
  /// Можно передать идентификатор,
  /// если обновление надо запросить по конкретному идентификатору
  @Implements<_OptionalIdContainer>()
  @With<_ProcessedStateEmitter>()
  @With<_NotFoundStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_FetchedStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory JobEvent.fetch([final int? id]) = _FetchJobEvent;

  /// Обновить (перезаписать) работу
  /// Передаем пользователя, которому должна принадлежать работа
  /// Работа обязательно должна содержать [id] и принадлежать текущему пользователю
  @Implements<_JobDataContainer>()
  @With<_ProcessedStateEmitter>()
  @With<_NotFoundStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_SavedStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory JobEvent.update({required final JobData data}) = _UpdateJobEvent;

  /// Удалить работу
  /// Передаем пользователя, которому должна принадлежать работа
  /// Работа обязательно должна содержать [id] и принадлежать текущему пользователю
  @With<_ProcessedStateEmitter>()
  @With<_NotFoundStateEmitter>()
  @With<_ErrorStateEmitter>()
  @With<_DeletedStateEmitter>()
  @With<_IdleStateEmitter>()
  const factory JobEvent.delete() = _DeleteJobEvent;
}

@freezed
class JobState with _$JobState {
  const JobState._();

  /// Текущая работа
  @override
  Job get job;

  /// Это новая, еще не записаная работа?
  bool get hasNotID => job.hasNotID;

  /// Есть ли идентификатор у работы?
  bool get hasID => job.hasID;

  /// Выполняется обработка
  bool get isProcessed => maybeMap<bool>(
        orElse: () => false,
        processed: (_) => true,
      );

  /// В ожидании событий
  const factory JobState.idle({
    required final Job job,
    @Default('Idle') final String message,
  }) = _IdleJobState;

  /// Выполняется обработка
  const factory JobState.processed({
    required final Job job,
    @Default('Processed') final String message,
  }) = _ProcessedJobState;

  /// Работа сохранена или создана
  const factory JobState.saved({
    required final Job job,
    @Default('Successfully saved') final String message,
  }) = _SavedJobState;

  /// Работа получена
  const factory JobState.fetched({
    required final Job job,
    @Default('Successfully fetched') final String message,
  }) = _FetchedJobState;

  /// Работа удалена
  const factory JobState.deleted({
    required final Job job,
    @Default('Successfully deleted') final String message,
  }) = _DeletedJobState;

  /// Работа не найдена
  /// Вероятно была удалена или открыта по не существующему идентификатору
  const factory JobState.notFound({
    required final Job job,
    @Default('Not found') final String message,
  }) = _NotFoundJobState;

  /// Произошла ошибка
  const factory JobState.error({
    required final Job job,
    @Default('An error has occurred') final String message,
  }) = _ErrorJobState;
}

class JobBLoC extends Bloc<JobEvent, JobState> {
  final IJobRepository _repository;

  /// БЛоК создан для уже существующей работы
  JobBLoC({
    required final IJobRepository repository,
    required final Job job,
  })  : _repository = repository,
        super(JobState.idle(job: job));

  /// БЛоК создан для создания новой работы
  JobBLoC.creation({
    required final IJobRepository repository,
  })  : _repository = repository,
        super(JobState.idle(job: repository.getNewJobTemplate()));

  @override
  Stream<JobState> mapEventToState(final JobEvent event) => event.map<Stream<JobState>>(
        create: _create,
        fetch: _fetch,
        update: _update,
        delete: _delete,
      );

  Stream<JobState> _fetch(_FetchJobEvent event) async* {
    final id = event.id ?? state.job.id;
    if (id.isNegative) return;
    try {
      yield event.inProgress(state: state);
      final job = await _repository.getJob(id: id).timeout(const Duration(seconds: 10));
      yield event.fetched(state: state, job: job);
    } on NotFoundException {
      yield event.notFound(state: state);
    } on Object {
      yield event.error(state: state, message: 'Unsupported error');
      rethrow;
    } finally {
      yield event.idle(state: state);
    }
  }

  Stream<JobState> _create(_CreateJobEvent event) async* {
    try {
      yield event.inProgress(state: state);
      final job = await _repository.createJob(jobData: event.data).timeout(const Duration(seconds: 10));
      yield event.saved(state: state, job: job);
    } on NotFoundException {
      yield event.notFound(state: state);
    } on Object {
      yield event.error(state: state, message: 'Unsupported error');
      rethrow;
    } finally {
      yield event.idle(state: state);
    }
  }

  Stream<JobState> _update(_UpdateJobEvent event) async* {
    try {
      yield event.inProgress(state: state);
      var newJob = state.job.copyWith(data: event.data);
      if (newJob.hasNotID) {
        throw const FormatException('Job has not exist');
      }
      newJob = await _repository.updateJob(job: newJob).timeout(const Duration(seconds: 10));
      yield event.saved(state: state, job: newJob);
    } on NotFoundException {
      yield event.notFound(state: state);
    } on Object {
      yield event.error(state: state, message: 'Unsupported error');
      rethrow;
    } finally {
      yield event.idle(state: state);
    }
  }

  Stream<JobState> _delete(_DeleteJobEvent event) async* {
    try {
      yield event.inProgress(state: state);
      var deletedJob = state.job;
      if (deletedJob.hasNotID) {
        throw const FormatException('Job has not exist');
      }
      deletedJob = await _repository.deleteJob(job: deletedJob).timeout(const Duration(seconds: 10));
      yield event.deleted(state: state, job: deletedJob);
    } on NotFoundException {
      yield event.notFound(state: state);
    } on Object {
      yield event.error(state: state, message: 'Unsupported error');
      rethrow;
    } finally {
      yield event.idle(state: state);
    }
  }
}

/* Миксины для эвентов и стейтов */

abstract class _JobDataContainer {
  JobData get data;
}

abstract class _OptionalIdContainer {
  int? get id;
}

/// Создание состояний "в обработке"
mixin _ProcessedStateEmitter on JobEvent {
  /// Создание состояния "в обработке", [state] - текущее состояние
  JobState inProgress({
    required final JobState state,
    final String? message,
  }) =>
      JobState.processed(
        job: state.job,
        message: message ?? 'Processed',
      );
}

/// Выпуск состояния ошибки
mixin _ErrorStateEmitter on JobEvent {
  /// Произошла ошибка
  JobState error({
    required final JobState state,
    final String? message,
  }) =>
      JobState.error(
        job: state.job,
        message: message ?? 'An error has occurred',
      );
}

/// Выпуск состояния отсутсвующих данных
mixin _NotFoundStateEmitter on JobEvent {
  /// Данные отсутсвуют
  JobState notFound({
    required final JobState state,
    final String? message,
  }) =>
      JobState.error(
        job: state.job,
        message: message ?? 'Not found',
      );
}

/// Выпуск состояния успешного сохранения
mixin _SavedStateEmitter on JobEvent {
  /// Выпуск состояния успешного сохранения
  JobState saved({
    required final JobState state,
    required final Job job,
    final String? message,
  }) =>
      JobState.saved(
        job: job,
        message: message ?? 'Successfully saved',
      );
}

/// Выпуск состояния успешного запроса
mixin _FetchedStateEmitter on JobEvent {
  /// Выпуск состояния успешного запроса
  JobState fetched({
    required final JobState state,
    required final Job job,
    final String? message,
  }) =>
      JobState.fetched(
        job: job,
        message: message ?? 'Successfully fetched',
      );
}

/// Выпуск состояния успешного удаления
mixin _DeletedStateEmitter on JobEvent {
  /// Выпуск состояния успешного удаления
  JobState deleted({
    required final JobState state,
    final Job? job,
    final String? message,
  }) =>
      JobState.deleted(
        job: (job ?? state.job).copyWith(
          deletionMark: true,
        ),
        message: message ?? 'Successfully deleted',
      );
}

/// Состояние ожидания действий пользователя
mixin _IdleStateEmitter on JobEvent {
  /// Состояние ожидания действий пользователя
  JobState idle({
    required final JobState state,
    final String? message,
  }) =>
      JobState.idle(
        job: state.job,
        message: message ?? 'Idle',
      );
}
