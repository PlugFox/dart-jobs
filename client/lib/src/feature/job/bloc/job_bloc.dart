import 'dart:async';

import 'package:dart_jobs/src/common/model/exceptions.dart';
import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs_shared/models.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_bloc.freezed.dart';

@freezed
class JobEvent with _$JobEvent {
  const JobEvent._();

  /// Создать новую работу
  /// Передаем пользователя, которому должна принадлежать работа
  const factory JobEvent.create({
    required final AuthenticatedUser user,
    required final Job job,
  }) = _CreateJobEvent;

  /// Запросить обновление по текущей работе
  /// Можно передать идентификатор,
  /// если обновление надо запросить по конкретному идентификатору
  const factory JobEvent.fetch([
    final String? id,
  ]) = _FetchJobEvent;

  /// Обновить (перезаписать) работу
  /// Передаем пользователя, которому должна принадлежать работа
  const factory JobEvent.update({
    required final AuthenticatedUser user,
    required final Job job,
  }) = _UpdateJobEvent;

  /// Удалить работу
  /// Передаем пользователя, которому должна принадлежать работа
  const factory JobEvent.delete({
    required final AuthenticatedUser user,
    required final Job job,
  }) = _DeleteJobEvent;
}

@freezed
class JobState with _$JobState {
  const JobState._();

  /// Текущая работа
  @override
  Job get job;

  /// Это новая, еще не записаная работа?
  bool get isNew => job.id.isEmpty;

  /// Есть ли идентификатор у работы?
  bool get isNotNew => job.id.isNotEmpty;

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

  JobBLoC({
    required final IJobRepository repository,
    required final JobState initialState,
  })  : _repository = repository,
        super(initialState);

  @override
  Stream<JobState> mapEventToState(final JobEvent event) => event.when<Stream<JobState>>(
        create: _create,
        fetch: _fetch,
        update: _update,
        delete: _delete,
      );

  Stream<JobState> _fetch([
    final String? id,
  ]) async* {
    var currentJob = state.job;
    if (id != null && id.isEmpty && currentJob.isEmpty) return;
    try {
      yield JobState.processed(job: currentJob);
      currentJob = await _repository.fetchById(id ?? currentJob.id);
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
      yield JobState.idle(job: currentJob);
      rethrow;
    }
  }

  Stream<JobState> _create(
    final AuthenticatedUser user,
    final Job job,
  ) async* {
    try {
      yield JobState.processed(job: job);
      final r = job.validate();
      if (r != null) {
        yield JobState.error(
          job: job,
          message: r,
        );
        return;
      }
      final savedJob = await _repository.create(
        user: user,
        title: job.title,
        company: job.company,
        country: job.country,
        location: job.location,
        remote: job.remote,
        salaryFrom: job.salaryFrom,
        salaryTo: job.salaryTo,
        attributes: job.attributes,
      );
      yield JobState.saved(job: savedJob);
    } on NotFoundException {
      yield JobState.notFound(
        job: job,
      );
    } on Object {
      yield JobState.error(
        job: state.job,
        message: 'Unsupported exception',
      );
      rethrow;
    } finally {
      yield JobState.idle(job: state.job);
    }
  }

  Stream<JobState> _update(
    final AuthenticatedUser user,
    final Job job,
  ) async* {
    if (job.isEmpty || state.job.creatorId != user.uid || job.creatorId != user.uid) {
      yield JobState.error(
        job: job,
        message: 'Authorization exception',
      );
      yield JobState.idle(job: job);
      return;
    }
    try {
      yield JobState.processed(job: job);
      final r = job.validate();
      if (r != null) {
        yield JobState.error(
          job: job,
          message: r,
        );
        return;
      }
      await _repository.update(job);
      final savedJob = job;
      yield JobState.saved(job: savedJob);
    } on NotFoundException {
      yield JobState.notFound(
        job: job,
      );
    } on Object {
      yield JobState.error(
        job: state.job,
        message: 'Unsupported exception',
      );
      rethrow;
    } finally {
      yield JobState.idle(job: state.job);
    }
  }

  Stream<JobState> _delete(
    final AuthenticatedUser user,
    final Job job,
  ) async* {
    if (job.isEmpty || state.job.creatorId != user.uid || job.creatorId != user.uid) {
      yield JobState.error(
        job: job,
        message: 'Authorization exception',
      );
      yield JobState.idle(job: job);
      return;
    }
    try {
      yield JobState.processed(job: job);
      await _repository.delete(job);
      yield JobState.deleted(job: job);
    } on NotFoundException {
      yield JobState.notFound(
        job: job,
      );
    } on Object {
      yield JobState.error(
        job: state.job,
        message: 'Unsupported exception',
      );
      rethrow;
    } finally {
      yield JobState.idle(job: state.job);
    }
  }
}
