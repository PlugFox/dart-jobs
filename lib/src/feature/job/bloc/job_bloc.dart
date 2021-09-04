import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/job.dart';

part 'job_bloc.freezed.dart';

@freezed
class JobEvent with _$JobEvent {
  const JobEvent._();
  const factory JobEvent.create() = _CreateJobEvent;

  const factory JobEvent.fetch() = _FetchJobEvent;

  const factory JobEvent.update() = _UpdateJobEvent;

  const factory JobEvent.delete() = _DeleteJobEvent;
}

@freezed
class JobState with _$JobState {
  const JobState._();

  const factory JobState.fetching({
    required final Job job,
  }) = _FetchingJobState;

  const factory JobState.filled({
    required final Job job,
  }) = _FilledJobState;

  const factory JobState.error({
    required final Job job,
    required final String message,
  }) = _ErrorJobState;
}

class JobBLoC extends Bloc<JobEvent, JobState> {
  JobBLoC({
    required final JobState initialState,
  }) : super(initialState);

  @override
  Stream<JobState> mapEventToState(JobEvent event) => event.when<Stream<JobState>>(
        create: _create,
        fetch: _fetch,
        update: _update,
        delete: _delete,
      );

  Stream<JobState> _create() async* {
    // ...
  }

  Stream<JobState> _fetch() async* {
    yield JobState.fetching(job: state.job);
    await Future<void>.delayed(const Duration(seconds: 2));
    yield JobState.error(job: state.job, message: 'Error');
  }

  Stream<JobState> _update() async* {
    // ...
  }

  Stream<JobState> _delete() async* {
    // ...
  }
}
