import 'dart:math' as math show Random;

import 'package:dart_jobs/src/common/model/proposal.dart';
import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/job/data/job_network_data_provider.dart';
import 'package:money2/money2.dart';

abstract class IJobRepository {
  /// Создать новую работу
  Future<Job> create({
    required final AuthenticatedUser user,
    required final String title,
    required final String company,
    required final String country,
    required final String location,
    required final bool remote,
    required final Money salaryFrom,
    required final Money salaryTo,
    JobAttributes attributes = const JobAttributes.empty(),
  });

  /// Запросить данные работы по идентификатору
  Future<Job> fetchById(final String id);

  /// Запросить данные работы
  Future<Job> fetch(final Job job);

  /// Обновить работу
  Future<void> update(final Job job);

  /// Удалить работу по идентификатору
  Future<void> deleteById(final String id);

  /// Удалить работу
  Future<void> delete(final Job job);
}

class JobRepositoryImpl implements IJobRepository {
  final IJobNetworkDataProvider _networkDataProvider;
  JobRepositoryImpl({
    required final IJobNetworkDataProvider networkDataProvider,
  }) : _networkDataProvider = networkDataProvider;

  @override
  Future<Job> create({
    required final AuthenticatedUser user,
    required final String title,
    required final String company,
    required final String country,
    required final String location,
    required final bool remote,
    required final Money salaryFrom,
    required final Money salaryTo,
    JobAttributes attributes = const JobAttributes.empty(),
  }) =>
      _networkDataProvider.create(
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

  @override
  Future<Job> fetchById(String id) => _networkDataProvider.fetchById(id);

  @override
  Future<Job> fetch(Job job) => fetchById(job.id);

  @override
  Future<void> update(Job job) => _networkDataProvider.update(job);

  @override
  Future<void> deleteById(String id) => _networkDataProvider.deleteById(id);

  @override
  Future<void> delete(Job job) => deleteById(job.id);
}

class JobRepositoryFake implements IJobRepository {
  static math.Random get _rnd => __rnd ??= math.Random();
  static math.Random? __rnd;
  static final Map<String, Job> _jobs = <String, Job>{};

  @override
  Future<Job> create({
    required final AuthenticatedUser user,
    required final String title,
    required final String company,
    required final String country,
    required final String location,
    required final bool remote,
    required final Money salaryFrom,
    required final Money salaryTo,
    JobAttributes attributes = const JobAttributes.empty(),
  }) async {
    final now = DateTime.now();
    final newJob = Job(
      id: DateTime.now().millisecondsSinceEpoch.toRadixString(36),
      creatorId: user.uid,
      title: title,
      company: company,
      country: country,
      location: location,
      remote: remote,
      salaryFrom: salaryFrom,
      salaryTo: salaryTo,
      attributes: attributes,
      created: now,
      updated: now,
    );
    await Future<void>.delayed(const Duration(seconds: 1));
    _jobs[newJob.id] = newJob;
    return newJob;
  }

  @override
  Future<Job> fetchById(final String id) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final now = DateTime.now();
    return _jobs[id] ??= Job(
      id: id,
      creatorId: _rnd.nextInt(2).toRadixString(36),
      title: 'Some job',
      company: 'company',
      country: 'country',
      location: 'location',
      remote: true,
      created: now,
      updated: now,
    );
  }

  @override
  Future<Job> fetch(final Job job) => fetchById(job.id);

  @override
  Future<void> update(final Job job) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _jobs[job.id] = job;
  }

  @override
  Future<void> deleteById(final String id) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _jobs.remove(id);
  }

  @override
  Future<void> delete(final Job job) => deleteById(job.id);
}
