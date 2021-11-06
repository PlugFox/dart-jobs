import 'dart:async';

import 'package:dart_jobs/src/common/model/exceptions.dart';
import 'package:dart_jobs/src/feature/job/data/job_network_data_provider.dart';
import 'package:dart_jobs_shared/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IJobRepository {
  /// Запросить новейшие
  /// Получение последних записей по указаной фильтрации
  Future<JobsChunk> getRecent({
    required final DateTime updatedAfter,
    required final JobFilter filter,
  });

  /// Запросить порцию старых
  /// Получение последних записей по указаной фильтрации
  Future<JobsChunk> paginate({
    required final DateTime updatedBefore,
    required final JobFilter filter,
  });

  /// Запросить порцию старых
  Future<Job> createJob({required final JobData jobData});

  /// Получить работу по идентификатору
  /// Если работа не найдена - возвращает с пометкой [deletionMark]
  Future<Job> getJob({required final String id});

  /// Обновить данные по работе
  /// В ответ получаем обновленную работу
  Future<Job> updateJob({required final Job job});

  /// Удалить работу по идентификатору
  Future<Job> deleteJob({required final Job job});
}

class JobRepositoryImpl implements IJobRepository {
  final IJobNetworkDataProvider _networkDataProvider;
  final FirebaseAuth _firebaseAuth;
  JobRepositoryImpl({
    required final IJobNetworkDataProvider networkDataProvider,
    required final FirebaseAuth firebaseAuth,
  })  : _networkDataProvider = networkDataProvider,
        _firebaseAuth = firebaseAuth;

  @override
  Future<JobsChunk> getRecent({
    required DateTime updatedAfter,
    required JobFilter filter,
  }) =>
      _networkDataProvider.getRecent(
        updatedAfter: updatedAfter,
        filter: filter,
      );

  @override
  Future<JobsChunk> paginate({
    required DateTime updatedBefore,
    required JobFilter filter,
  }) =>
      _networkDataProvider.paginate(
        updatedBefore: updatedBefore,
        filter: filter,
      );

  @override
  Future<Job> createJob({required JobData jobData}) async {
    final idToken = await _firebaseAuth.currentUser?.getIdToken(true);
    if (idToken == null || idToken.isEmpty) {
      throw NotAuthorized(StackTrace.current, 'Token not received');
    }
    return _networkDataProvider.createJob(jobData: jobData, idToken: idToken);
  }

  @override
  Future<Job> getJob({required String id}) => _networkDataProvider.getJob(id: id);

  @override
  Future<Job> updateJob({required Job job}) async {
    final idToken = await _firebaseAuth.currentUser?.getIdToken(true);
    if (idToken == null || idToken.isEmpty) {
      throw NotAuthorized(StackTrace.current, 'Token not received');
    }
    return _networkDataProvider.updateJob(job: job, idToken: idToken);
  }

  @override
  Future<Job> deleteJob({required Job job}) async {
    final idToken = await _firebaseAuth.currentUser?.getIdToken(true);
    if (idToken == null || idToken.isEmpty) {
      throw NotAuthorized(StackTrace.current, 'Token not received');
    }
    return _networkDataProvider.deleteJob(job: job, idToken: idToken);
  }
}
