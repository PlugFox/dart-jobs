import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jobs_client/src/common/model/exceptions.dart';
import 'package:dart_jobs_client/src/feature/job/data/job_network_data_provider.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IJobRepository {
  /// Получить новую, пустую работу с идентификатором текущего пользователя
  /// используется как основа для создания новой работы на сервере
  Job getNewJobTemplate();

  /// Запросить новейшие
  /// Получение последних записей по указаной фильтрации
  /// exclude - список идентификаторов не включаемых в выборку
  Future<JobsChunk> getRecent({
    required final DateTime updatedAfter,
    required final JobFilter filter,
    final List<int> exclude,
  });

  /// Запросить порцию старых
  /// Получение последних записей по указаной фильтрации
  Future<JobsChunk> paginate({
    required final DateTime updatedBefore,
    required final JobFilter filter,
    final List<int> exclude,
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

  /// Запомнить фильтр
  Future<void> saveFilter(JobFilter filter);

  /// Восстановить фильтр
  Future<JobFilter> restoreFilter();

  /// Последний сохранненый фильтр
  JobFilter get filter;
}

class JobRepositoryImpl implements IJobRepository {
  JobRepositoryImpl({
    required final IJobNetworkDataProvider networkDataProvider,
    required final FirebaseAuth firebaseAuth,
    required final FirebaseFirestore firestore,
    required final SharedPreferences sharedPreferences,
  })  : _networkDataProvider = networkDataProvider,
        _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _sharedPreferences = sharedPreferences;

  final IJobNetworkDataProvider _networkDataProvider;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final SharedPreferences _sharedPreferences;

  @override
  JobFilter get filter => _filter;
  JobFilter _filter = const JobFilter();

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
    final List<int> exclude = const <int>[],
  }) =>
      _networkDataProvider.getRecent(
        updatedAfter: updatedAfter,
        filter: filter,
        exclude: exclude,
      );

  @override
  Future<JobsChunk> paginate({
    required DateTime updatedBefore,
    required JobFilter filter,
    final List<int> exclude = const <int>[],
  }) =>
      _networkDataProvider.paginate(
        updatedBefore: updatedBefore,
        filter: filter,
        exclude: exclude,
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

  @override
  Future<JobFilter> restoreFilter() async {
    final user = _firebaseAuth.currentUser;
    JobFilter? filter;
    if (user != null) {
      final doc = _firestore.collection('users').doc(user.uid).collection('feed').doc('filter');
      final snapshot = await doc.get();
      final json = snapshot.data();
      if (json != null) {
        filter = JobFilter.fromJson(json);
      }
    }
    if (filter == null) {
      final jsonRaw = _sharedPreferences.getString('feed.filter');
      if (jsonRaw != null) {
        final json = jsonDecode(jsonRaw) as Map<String, Object?>;
        filter = JobFilter.fromJson(json);
      }
    }
    return _filter = filter ?? const JobFilter();
  }

  @override
  Future<void> saveFilter(JobFilter filter) async {
    _filter = filter;
    final user = _firebaseAuth.currentUser;
    final json = filter.toJson();
    if (user != null) {
      final doc = _firestore.collection('users').doc(user.uid).collection('feed').doc('filter');
      await doc.set(json, SetOptions(merge: false));
    }
    final jsonRaw = jsonEncode(json);
    await _sharedPreferences.setString('feed.filter', jsonRaw);
  }
}
