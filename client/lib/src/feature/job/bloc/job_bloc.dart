import 'dart:async';

import 'package:dart_jobs/src/common/model/exceptions.dart';
import 'package:dart_jobs/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs_shared/models.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_bloc.freezed.dart';

@freezed
class JobEvent with _$JobEvent {
  const JobEvent._();

  /// Создать новую работу
  /// Передаем данные работы
  /// Владельцем новой работы будет являться текущий пользователь
  const factory JobEvent.create({
    required final JobData data,
  }) = _CreateJobEvent;

  /// Запросить обновление по текущей работе
  /// Можно передать идентификатор,
  /// если обновление надо запросить по конкретному идентификатору
  const factory JobEvent.fetch([
    final String? id,
  ]) = _FetchJobEvent;

  /// Обновить (перезаписать) работу
  /// Передаем пользователя, которому должна принадлежать работа
  /// Работа обязательно должна содержать [id] и принадлежать текущему пользователю
  const factory JobEvent.update({
    required final JobData data,
  }) = _UpdateJobEvent;

  /// Удалить работу
  /// Передаем пользователя, которому должна принадлежать работа
  /// Работа обязательно должна содержать [id] и принадлежать текущему пользователю
  const factory JobEvent.delete() = _DeleteJobEvent;
}

@freezed
class JobState with _$JobState {
  const JobState._();

  /// Текущая работа
  @override
  Job get job;

  /// Это новая, еще не записаная работа?
  bool get hasNotID => job.id.isEmpty;

  /// Есть ли идентификатор у работы?
  bool get hasID => job.id.isNotEmpty;

  /// В ожидании событий
  const factory JobState.idle({
    required final Job job,
  }) = _IdleJobState;

  /// Выполняется обработка
  const factory JobState.processed({
    required final Job job,
  }) = _ProcessedJobState;

  /// Работа сохранена или создана
  const factory JobState.saved({
    required final Job job,
  }) = _SavedJobState;

  /// Работа удалена
  const factory JobState.deleted({
    required final Job job,
  }) = _DeletedJobState;

  /// Работа не найдена
  /// Вероятно была удалена или открыта по не существующему идентификатору
  const factory JobState.notFound({
    required final Job job,
  }) = _NotFoundJobState;

  /// Произошла ошибка
  const factory JobState.error({
    required final Job job,
    required final String message,
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
  Stream<JobState> mapEventToState(final JobEvent event) => event.when<Stream<JobState>>(
        create: _create,
        fetch: _fetch,
        update: _update,
        delete: _delete,
      );

  Stream<JobState> _fetch([final String? id]) async* {
    var currentJob = state.job;
    if (id != null && id.isEmpty && currentJob.hasNotID) return;
    try {
      yield JobState.processed(job: currentJob);
      currentJob = await _repository.getJob(id: id ?? currentJob.id);
      yield JobState.idle(job: currentJob);
    } on NotFoundException {
      yield JobState.notFound(
        job: currentJob,
      );
    } on Object {
      yield JobState.error(
        job: currentJob,
        message: 'Unsupported error',
      );
      rethrow;
    } finally {
      yield JobState.idle(job: currentJob);
    }
  }

  Stream<JobState> _create(final JobData data) async* {
    var job = state.job.copyWith(data: data);
    try {
      yield JobState.processed(job: job);
      job = await _repository.createJob(jobData: data);
      yield JobState.saved(job: job);
    } on NotFoundException {
      yield JobState.notFound(
        job: job,
      );
    } on Object {
      yield JobState.error(
        job: job,
        message: 'Unsupported exception',
      );
      rethrow;
    } finally {
      yield JobState.idle(job: job);
    }
  }

  Stream<JobState> _update(final JobData data) async* {
    var job = state.job.copyWith(data: data);
    try {
      if (job.hasNotID) {
        yield JobState.error(
          job: job,
          message: 'Job has not exist',
        );
        return;
      }
      yield JobState.processed(job: job);
      job = await _repository.updateJob(job: job);
      yield JobState.saved(job: job);
    } on NotFoundException {
      yield JobState.notFound(job: job);
    } on Object {
      yield JobState.error(
        job: job,
        message: 'Unsupported exception',
      );
      rethrow;
    } finally {
      yield JobState.idle(job: job);
    }
  }

  Stream<JobState> _delete() async* {
    var job = state.job;
    try {
      if (job.hasNotID) {
        yield JobState.error(
          job: job,
          message: 'Job has not exist',
        );
        return;
      }
      yield JobState.processed(job: job);
      job = await _repository.deleteJob(job: job);
      yield JobState.deleted(job: job);
    } on NotFoundException {
      yield JobState.notFound(
        job: job,
      );
    } on Object {
      yield JobState.error(
        job: job,
        message: 'Unsupported exception',
      );
      rethrow;
    } finally {
      yield JobState.idle(job: job);
    }
  }
}
