import 'package:dart_jobs/src/common/model/proposal.dart';
import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/job/data/job_repository.dart';
import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

part 'job_manager_bloc.freezed.dart';

@freezed
class JobManagerEvent with _$JobManagerEvent {
  const JobManagerEvent._();

  /// Создать новую работу
  const factory JobManagerEvent.create({
    required final AuthenticatedUser user,
    required final String title,
    required final String company,
    required final String country,
    required final String location,
    required final bool remote,
    required final Money salaryFrom,
    required final Money salaryTo,
    @Default(JobAttributes.empty()) final JobAttributes attributes,
  }) = _CreateJobManagerEvent;

  /// Удалить работу
  const factory JobManagerEvent.delete({
    required final AuthenticatedUser user,
    required final Job job,
  }) = _DeleteJobManagerEvent;
}

@freezed
class JobManagerState with _$JobManagerState {
  const JobManagerState._();

  /// Ожидание
  const factory JobManagerState.idle() = _IdleJobManagerState;

  /// Выполняется обработка
  const factory JobManagerState.processed() = _ProcessedJobManagerState;

  /// Работа создана
  const factory JobManagerState.created({
    required final Job job,
  }) = _CreatedJobManagerState;

  /// Работа удалена
  const factory JobManagerState.deleted({
    required final Job job,
  }) = _DeletedJobManagerState;

  /// Произошла ошибка
  const factory JobManagerState.error({
    required final String message,
  }) = _ErrorJobManagerState;
}

class JobManagerBLoC extends Bloc<JobManagerEvent, JobManagerState> {
  final IJobRepository _repository;
  JobManagerBLoC({required final IJobRepository repository})
      : _repository = repository,
        super(const JobManagerState.idle());

  @override
  Stream<JobManagerState> mapEventToState(final JobManagerEvent event) => event.when<Stream<JobManagerState>>(
        create: _create,
        delete: _delete,
      );

  Stream<JobManagerState> _create(
    final AuthenticatedUser user,
    final String title,
    final String company,
    final String country,
    final String location,
    final bool remote,
    final Money salaryFrom,
    final Money salaryTo,
    final JobAttributes attributes,
  ) async* {
    try {
      yield const JobManagerState.processed();
      final job = await _repository.create(
        user: user,
        title: title,
        company: company,
        country: country,
        location: location,
        remote: remote,
        salaryFrom: salaryFrom,
        salaryTo: salaryTo,
        attributes: attributes,
      );
      yield JobManagerState.created(job: job);
      yield const JobManagerState.idle();
    } on Object {
      yield const JobManagerState.error(message: 'Unsupported error');
      rethrow;
    }
  }

  Stream<JobManagerState> _delete(
    final AuthenticatedUser user,
    final Job job,
  ) async* {
    try {
      yield const JobManagerState.processed();
      await _repository.delete(job);
      yield JobManagerState.deleted(job: job);
      yield const JobManagerState.idle();
    } on Object {
      yield const JobManagerState.error(message: 'Unsupported error');
      rethrow;
    }
  }
}
