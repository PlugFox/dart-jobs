import 'dart:async';

import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/job_repository.dart';
import '../model/job.dart';

part 'job_bloc.freezed.dart';

@freezed
class JobEvent with _$JobEvent {
  const JobEvent._();

  const factory JobEvent.fetch() = _FetchJobEvent;

  const factory JobEvent.update(Job job) = _UpdateJobEvent;

  const factory JobEvent.delete() = _DeleteJobEvent;
}

@freezed
class JobState with _$JobState {
  const JobState._();

  const factory JobState.fetching({
    required final Job job,
  }) = _FetchingJobState;

  const factory JobState.idle({
    required final Job job,
  }) = _IdleJobState;

  const factory JobState.removed({
    required final Job job,
  }) = _RemovedJobState;

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
  Stream<JobState> mapEventToState(JobEvent event) => event.when<Stream<JobState>>(
        fetch: _fetch,
        update: _update,
        delete: _delete,
      );

  @override
  Stream<Transition<JobEvent, JobState>> transformEvents(
    Stream<JobEvent> events,
    TransitionFunction<JobEvent, JobState> transitionFn,
  ) =>
      super.transformEvents(
        events.transform<JobEvent>(
          StreamTransformer.fromHandlers(
            handleData: (event, sink) => state.maybeMap(
              orElse: () => sink.add(event),
              fetching: (_) => null,
            ),
          ),
        ),
        transitionFn,
      );

  /*
  Stream<JobState> _create(String title, AuthenticatedUser user, JobAttributes attributes) async* {
    if (state.job.isNotEmpty) return;
    try {
      yield JobState.fetching(
        job: Job.create(
          id: '',
          creatorId: user.uid,
          title: title,
          attributes: attributes,
        ),
      );
      final job = await _repository.create(
        title: title,
        user: user,
        attributes: attributes,
      );
      yield JobState.idle(job: job);
    } on Object {
      yield JobState.error(job: state.job, message: 'Unsupported error');
      rethrow;
    }
  }
  */

  Stream<JobState> _fetch() async* {
    if (state.job.isEmpty) return;
    try {
      yield JobState.fetching(job: state.job);
      final job = await _repository.fetch(state.job);
      yield JobState.idle(job: job);
    } on JobNotFoundException catch (err) {
      yield JobState.error(job: state.job, message: err.toString());
    } on Object {
      yield JobState.error(job: state.job, message: 'Unsupported error');
      rethrow;
    }
  }

  Stream<JobState> _update(Job job) async* {
    if (job.isEmpty) return;
    try {
      yield JobState.fetching(job: job);
      await _repository.update(job);
      yield JobState.idle(job: job);
    } on Object {
      yield JobState.error(job: job, message: 'Unsupported error');
      rethrow;
    }
  }

  Stream<JobState> _delete() async* {
    if (state.job.isEmpty) return;
    try {
      yield JobState.fetching(job: state.job);
      await _repository.delete(state.job);
      yield JobState.removed(job: state.job);
    } on Object {
      yield JobState.error(job: state.job, message: 'Unsupported error');
      rethrow;
    }
  }
}
