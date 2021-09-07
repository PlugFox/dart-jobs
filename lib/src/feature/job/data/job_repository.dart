import 'dart:math' as math show Random;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

import '../../authentication/model/user_entity.dart';
import '../model/job.dart';

abstract class IJobRepository {
  Future<Job> create({
    required String title,
    required AuthenticatedUser user,
    JobAttributes attributes = const JobAttributes.empty(),
  });

  Future<Job> fetchById(String id);

  Future<Job> fetch(Job job);

  Future<void> update(Job job);

  Future<void> deleteById(String id);

  Future<void> delete(Job job);
}

class JobRepositoryFirebase implements IJobRepository {
  /// Коллекция
  final CollectionReference _collection;

  JobRepositoryFirebase({
    required final FirebaseFirestore firestore,
  }) : _collection = firestore.collection('feed');

  @override
  Future<Job> create({
    required String title,
    required AuthenticatedUser user,
    JobAttributes attributes = const JobAttributes.empty(),
  }) async {
    final doc = _collection.doc();
    final newJob = Job.create(
      id: doc.id,
      creatorId: user.uid,
      title: title,
      attributes: attributes,
    );
    await doc.set(
      newJob.toJson(),
      SetOptions(merge: false),
    );
    return newJob;
  }

  @override
  Future<Job> fetchById(String id) async {
    final snapshot = await _collection.doc(id).get(const GetOptions(source: Source.serverAndCache));
    final data = snapshot.data() as Map<String, Object?>?;
    if (!snapshot.exists || data == null) {
      l.w('Работа по идентификатору "$id" не найдена');
      _throwNotFound(id);
    }
    return Job.fromJson(data);
  }

  @override
  Future<Job> fetch(Job job) => fetchById(job.id);

  @override
  Future<void> update(Job job) => _collection.doc(job.id).set(job.toJson());

  @override
  Future<void> deleteById(String id) => _collection.doc(id).delete();

  @override
  Future<void> delete(Job job) => deleteById(job.id);

  @alwaysThrows
  Never _throwNotFound(String id) => throw JobNotFoundException('no such job with identifier $id');
}

class JobRepositoryFake implements IJobRepository {
  static math.Random get _rnd => __rnd ??= math.Random();
  static math.Random? __rnd;
  static final Map<String, Job> _jobs = <String, Job>{};

  @override
  Future<Job> create({
    required String title,
    required AuthenticatedUser user,
    JobAttributes attributes = const JobAttributes.empty(),
  }) async {
    final newJob = Job.create(
      id: DateTime.now().millisecondsSinceEpoch.toRadixString(36),
      creatorId: user.uid,
      title: title,
      attributes: attributes,
    );
    await Future<void>.delayed(const Duration(seconds: 1));
    _jobs[newJob.id] = newJob;
    return newJob;
  }

  @override
  Future<Job> fetchById(String id) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return _jobs[id] ??= Job.create(
      id: DateTime.now().millisecondsSinceEpoch.toRadixString(36),
      creatorId: _rnd.nextInt(1024).toRadixString(36),
      title: 'Some job',
    );
  }

  @override
  Future<Job> fetch(Job job) => fetchById(job.id);

  @override
  Future<void> update(Job job) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _jobs[job.id] = job;
  }

  @override
  Future<void> deleteById(String id) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _jobs.remove(id);
  }

  @override
  Future<void> delete(Job job) => deleteById(job.id);
}

class JobNotFoundException implements Exception {
  final String? message;

  const JobNotFoundException([this.message]);

  @override
  String toString() {
    if (message == null) return 'JobNotFoundException';
    return 'JobNotFoundException: $message';
  }
}
