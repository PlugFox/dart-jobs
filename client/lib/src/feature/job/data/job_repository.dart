import 'dart:async';
import 'dart:math' as math;

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
        data: JobData(
          title: _WorkTitleRandomizer.instance().next(),
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

// ignore: unused_element
class _WorkTitleRandomizer {
  _WorkTitleRandomizer._();
  static _WorkTitleRandomizer? _instance;
  // ignore: unused_element
  factory _WorkTitleRandomizer.instance() => _instance ??= _WorkTitleRandomizer._();
  static const List<String> _variants = <String>[
    'Best work ever',
    "Let's work together",
    'Dart developer required',
    'Most wanted',
    'Payment by cookies',
    'Hiring for everyone',
    'Dart goez fasta, brrr',
  ];
  final math.Random _rnd = math.Random();
  final int _max = _variants.length - 1;
  String next() => _variants[_rnd.nextInt(_max)];
}
