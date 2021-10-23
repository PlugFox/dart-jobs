import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/job/model/job.dart';
import 'package:dart_jobs/src/feature/job/model/job_not_found_exception.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';
import 'package:money2/money2.dart';

abstract class JobNetworkDataProvider {
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
    required final JobAttributes attributes,
  });

  /// Запросить данные работы по идентификатору
  Future<Job> fetchById(final String id);

  /// Обновить работу
  Future<void> update(final Job job);

  /// Удалить работу по идентификатору
  Future<void> deleteById(final String id);
}

class JobFirestoreDataProvider implements JobNetworkDataProvider {
  /// Клиент Firebase Firestore
  final FirebaseFirestore _firestore;

  /// Коллекция работы
  final CollectionReference _feedCollection;

  /// Коллекция аттрибутов работы
  final CollectionReference _attributesCollection;

  JobFirestoreDataProvider({
    required final FirebaseFirestore firestore,
  })  : _firestore = firestore,
        _feedCollection = firestore.collection('feed'),
        _attributesCollection = firestore.collection('job_attributes');

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
    required final JobAttributes attributes,
  }) async {
    // Сохраняем работу
    final doc = _feedCollection.doc();
    final newJob = Job.create(
      id: doc.id,
      creatorId: user.uid,
      title: title,
      company: company,
      country: country,
      location: location,
      remote: remote,
      salaryFrom: salaryFrom,
      salaryTo: salaryTo,
      attributes: attributes,
    );
    await update(newJob);
    return newJob;
  }

  @override
  Future<Job> fetchById(final String id) async {
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
  Future<void> update(final Job job) {
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
  Future<void> deleteById(final String id) => (_firestore.batch()
        ..delete(_feedCollection.doc(id))
        ..delete(_attributesCollection.doc(id)))
      .commit();

  @alwaysThrows
  Never _throwNotFound(final String id) => throw JobNotFoundException(
        StackTrace.current,
        'no such job with identifier $id',
      );
}
