import 'package:fox_core_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/model/proposal.dart';
import '../../authentication/model/user_entity.dart';
import '../data/job_repository.dart';

part 'job_manager_bloc.freezed.dart';

@freezed
class JobManagerEvent with _$JobManagerEvent {
  const JobManagerEvent._();

  /// Создать новую работу
  const factory JobManagerEvent.create({
    required String title,
    required AuthenticatedUser user,
    @Default(JobAttributes.empty()) JobAttributes attributes,
  }) = _CreateJobManagerEvent;

  /// Удалить работу
  const factory JobManagerEvent.delete({
    required AuthenticatedUser user,
    required Job job,
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
  JobManagerBLoC({required IJobRepository repository})
      : _repository = repository,
        super(const JobManagerState.idle());

  @override
  Stream<JobManagerState> mapEventToState(JobManagerEvent event) => event.when<Stream<JobManagerState>>(
        create: _create,
        delete: _delete,
      );

  Stream<JobManagerState> _create(String title, AuthenticatedUser user, JobAttributes attributes) async* {
    try {
      yield const JobManagerState.processed();
      final job = await _repository.create(
        title: title,
        user: user,
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
    AuthenticatedUser user,
    Job job,
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
