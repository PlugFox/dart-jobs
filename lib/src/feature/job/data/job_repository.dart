import 'dart:math' as math show Random;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

import '../../authentication/model/user_entity.dart';
import '../model/job.dart';

abstract class IJobRepository {
  /// Создать новую работу
  Future<Job> create({
    required final AuthenticatedUser user,
    required final String title,
    required final String company,
    required final String location,
    required final String salary,
    JobAttributes attributes = const JobAttributes.empty(),
  });

  /// Запросить данные работы по идентификатору
  Future<Job> fetchById(String id);

  /// Запросить данные работы
  Future<Job> fetch(Job job);

  /// Обновить работу
  Future<void> update(Job job);

  /// Удалить работу по идентификатору
  Future<void> deleteById(String id);

  /// Удалить работу
  Future<void> delete(Job job);
}

class JobRepositoryFirebase implements IJobRepository {
  final FirebaseFirestore _firestore;

  /// Коллекция работы
  final CollectionReference _feedCollection;

  /// Коллекция аттрибутов работы
  final CollectionReference _attributesCollection;

  JobRepositoryFirebase({
    required final FirebaseFirestore firestore,
  })  : _firestore = firestore,
        _feedCollection = firestore.collection('feed'),
        _attributesCollection = firestore.collection('job_attributes');

  @override
  Future<Job> create({
    required final AuthenticatedUser user,
    required final String title,
    required final String company,
    required final String location,
    required final String salary,
    JobAttributes attributes = const JobAttributes.empty(),
  }) async {
    final batch = _firestore.batch();
    // Сохраняем работу
    final doc = _feedCollection.doc();
    final newJob = Job.create(
      id: doc.id,
      creatorId: user.uid,
      title: title,
      company: company,
      location: location,
      salary: salary,
      attributes: attributes,
      hasEnglishLocalization: attributes.get(DescriptionJobAttribute.signature)?.isNotEmpty ?? false,
      hasRussianLocalization: attributes.get(DescriptionRuJobAttribute.signature)?.isNotEmpty ?? false,
    );
    final json = newJob.toJson();
    batch.set(
      doc,
      json,
      SetOptions(merge: false),
    );

    // Сохраняем аттрибуты работы
    if (attributes.isNotEmpty) {
      final doc = _attributesCollection.doc();
      final json = attributes.toJson(
        parentId: doc.id,
        creatorId: user.uid,
      )..putIfAbsent('parent', () => doc);
      batch.set(
        doc,
        json,
        SetOptions(merge: false),
      );
    }
    await batch.commit();
    return newJob;
  }

  @override
  Future<Job> fetchById(String id) async {
    // Получим работу по идентификатору
    final jobSnapshot = await _feedCollection.doc(id).get(const GetOptions(source: Source.serverAndCache));
    final jobData = jobSnapshot.data() as Map<String, Object?>?;
    if (!jobSnapshot.exists || jobData == null) {
      l.w('Работа по идентификатору "$id" не найдена');
      _throwNotFound(id);
    }
    final job = Job.fromJson(jobData);

    // Проверим наличие аттрибутов для работы
    final attributesSnapshot = await _attributesCollection.doc(id).get(const GetOptions(source: Source.serverAndCache));
    final attributesData = attributesSnapshot.data() as Map<String, Object?>?;
    if (attributesSnapshot.exists && attributesData != null) {
      final attributes = JobAttributes.fromJson(attributesData);
      if (attributes.isNotEmpty) {
        return job.copyWith(
          newAttributes: attributes,
        );
      }
    }
    return job;
  }

  @override
  Future<Job> fetch(Job job) => fetchById(job.id);

  @override
  Future<void> update(Job job) {
    final doc = _feedCollection.doc(job.id);
    final batch = _firestore.batch()..set(doc, job.toJson(), SetOptions(merge: false));
    if (job.attributes.isEmpty) {
      batch.delete(_attributesCollection.doc(job.id));
    } else {
      batch.set(
        _attributesCollection.doc(job.id),
        job.attributes.toJson(
          parentId: job.id,
          creatorId: job.creatorId,
        )..putIfAbsent('parent', () => doc),
        SetOptions(merge: false),
      );
    }
    return batch.commit();
  }

  @override
  Future<void> deleteById(String id) => (_firestore.batch()
        ..delete(_feedCollection.doc(id))
        ..delete(_attributesCollection.doc(id)))
      .commit();

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
    required final AuthenticatedUser user,
    required final String title,
    required final String company,
    required final String location,
    required final String salary,
    JobAttributes attributes = const JobAttributes.empty(),
  }) async {
    final newJob = Job.create(
      id: DateTime.now().millisecondsSinceEpoch.toRadixString(36),
      creatorId: user.uid,
      title: title,
      company: company,
      location: location,
      salary: salary,
      attributes: attributes,
      hasEnglishLocalization: true,
      hasRussianLocalization: true,
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
      creatorId: _rnd.nextInt(2).toRadixString(36),
      title: 'Some job',
      company: 'company',
      location: 'location',
      salary: 'salary',
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
