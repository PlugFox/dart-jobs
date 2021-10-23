import 'dart:async';

import 'package:dart_jobs/src/common/model/exceptions.dart';
import 'package:dart_jobs/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs/src/feature/job/model/job.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_bloc.freezed.dart';

@freezed
class JobEvent with _$JobEvent {
  const JobEvent._();

  /// Запросить редактирование текущей работы
  /// Передаем идентификатор пользователя, чтоб убедится, что работа принадлежит ему
  const factory JobEvent.edit(final String uid) = _EditJobEvent;

  /// Запросить просмотр
  const factory JobEvent.view() = _ViewJobEvent;

  /// Запросить обновление по работе
  const factory JobEvent.fetch() = _FetchJobEvent;

  /// Обновить (перезаписать) работу
  /// Передаем идентификатор пользователя, чтоб убедится, что работа принадлежит ему
  const factory JobEvent.update(final Job job, final String uid) = _UpdateJobEvent;
}

@freezed
class JobState with _$JobState {
  const JobState._();

  /// Текущая работа
  @override
  Job get job;

  /// Просмотр работы
  bool get viewing => !editing;

  /// Редактирование работы
  @override
  bool get editing;

  /// Обновляется
  const factory JobState.fetching({
    required final Job job,
    required final bool editing,
  }) = _FetchingJobState;

  /// В ожидании событий
  const factory JobState.idle({
    required final Job job,
    required final bool editing,
  }) = _IdleJobState;

  /// Работа не найдена
  /// Вероятно была удалена или открыта по не существующему идентификатору
  const factory JobState.notFound({
    required final Job job,
    @Default(false) final bool editing,
  }) = _NotFoundJobState;

  /// Произошла ошибка
  const factory JobState.error({
    required final Job job,
    required final bool editing,
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
        edit: _edit,
        view: _view,
        fetch: _fetch,
        update: _update,
      );

  @override
  Stream<Transition<JobEvent, JobState>> transformEvents(
    final Stream<JobEvent> events,
    final TransitionFunction<JobEvent, JobState> transitionFn,
  ) =>
      super.transformEvents(
        events.transform<JobEvent>(
          StreamTransformer.fromHandlers(
            handleData: (final event, final sink) => state.maybeMap(
              orElse: () => sink.add(event),
              fetching: (final _) => null,
            ),
          ),
        ),
        transitionFn,
      );

  Stream<JobState> _edit(final String uid) => state.job.creatorId != uid || state.editing
      ? const Stream<JobState>.empty()
      : Stream<JobState>.value(state.copyWith(editing: true));

  Stream<JobState> _view() =>
      state.viewing ? const Stream<JobState>.empty() : Stream<JobState>.value(state.copyWith(editing: false));

  Stream<JobState> _fetch() async* {
    if (state.job.isEmpty) return;
    try {
      yield JobState.fetching(job: state.job, editing: state.editing);
      final job = await _repository.fetch(state.job);
      yield JobState.idle(job: job, editing: state.editing);
    } on NotFoundException {
      yield JobState.notFound(
        job: Job(
          id: 'not_found',
          creatorId: 'not_found',
          title: 'Not found',
          created: DateTime.now(),
          updated: DateTime.now(),
          company: 'not_found',
          country: 'not_found',
          location: 'not_found',
          remote: true,
        ),
        editing: false,
      );
    } on Object {
      yield JobState.error(
        job: state.job,
        editing: state.editing,
        message: 'Unsupported error',
      );
      rethrow;
    }
  }

  Stream<JobState> _update(final Job job, final String uid) async* {
    if (job.isEmpty || state.job.creatorId != uid || job.creatorId != uid) return;
    try {
      yield JobState.fetching(job: job, editing: state.editing);
      await _repository.update(job);
      yield JobState.idle(job: job, editing: false);
    } on Object {
      yield JobState.error(job: job, editing: state.editing, message: 'Unsupported error');
      rethrow;
    }
  }
}
