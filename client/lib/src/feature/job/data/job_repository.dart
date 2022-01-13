import 'dart:async';

import 'package:dart_jobs_client/src/common/model/exceptions.dart';
import 'package:dart_jobs_client/src/feature/job/data/job_network_data_provider.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IJobRepository {
  /// Получить новую, пустую работу с идентификатором текущего пользователя
  /// используется как основа для создания новой работы на сервере
  Job getNewJobTemplate();

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
  Future<Job> getJob({required final int id});

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
  Job getNewJobTemplate() => Job(
        id: -1,
        creatorId: _firebaseAuth.currentUser?.uid ?? '',
        //weight: 0,
        created: DateTime.now(),
        updated: DateTime.now(),
        data: const JobData(
          title: '',
          company: '',
          address: '',
          remote: true,
          country: Countries.unknownCode,
          descriptions: Description(),
          relocation: Relocation.impossible(),
          levels: <DeveloperLevel>[
            DeveloperLevel.junior(),
            DeveloperLevel.middle(),
            DeveloperLevel.senior(),
            DeveloperLevel.lead(),
          ],
          employments: <Employment>[
            Employment.fullTime(),
          ],
          skills: <String>[],
          contacts: <String>[],
          tags: <String>[],
        ),
      );

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
    final currentUser = _firebaseAuth.currentUser;
    final uid = currentUser?.uid;
    final idToken = await currentUser?.getIdToken(true);
    if (idToken == null || uid == null || idToken.isEmpty) {
      throw NotAuthorized(StackTrace.current, 'Token not received');
    }
    return _networkDataProvider.createJob(jobData: jobData, idToken: idToken, creatorId: uid);
  }

  @override
  Future<Job> getJob({required int id}) => _networkDataProvider.getJob(id: id);

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
