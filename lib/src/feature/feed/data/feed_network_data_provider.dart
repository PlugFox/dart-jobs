import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jobs/src/common/model/proposal.dart';
import 'package:dart_jobs/src/common/model/proposal_change.dart';
import 'package:dart_jobs/src/common/utils/iterable_to_stream_coverter.dart';
import 'package:l/l.dart';

abstract class IFeedNetworkDataProvider {
  /// Получить по идентификатору
  /// Если возвращает null - элемент не найден, вероятно удален
  Future<Proposal?> getById({
    required final String id,
  });

  /// Запросить новейшие
  Stream<Proposal> fetchRecent({
    required final DateTime updatedAfter,
  });

  /// Подписка на последние события
  /// Стрим не заканчивается, элементы выбираются при появлении их в фаербейзе
  Stream<ProposalChange> subscribeOnRecent({
    required final DateTime updatedAfter,
  });

  /// Запросить порцию старых
  Stream<Proposal> paginate({
    required final DateTime updatedBefore,
    required final int count,
  });
}

class FeedFirestoreDataProvider implements IFeedNetworkDataProvider {
  /// Клиент Firebase Firestore
  // ignore: unused_field
  final FirebaseFirestore _firestore;

  /// Коллекция работы
  final CollectionReference _feedCollection;

  FeedFirestoreDataProvider({
    required final FirebaseFirestore firestore,
  })  : _firestore = firestore,
        _feedCollection = firestore.collection('feed');

  @override
  Stream<Proposal<Attribute>> fetchRecent({
    required final DateTime updatedAfter,
  }) =>
      Stream<QuerySnapshot<Object?>>.fromFuture(
        _feedCollection
            .where(
              'updated',
              isGreaterThan: DateUtil.toTimestamp(updatedAfter),
            )
            .orderBy(
              'updated',
              descending: false,
            )
            .limit(100)
            .get(
              const GetOptions(
                source: Source.serverAndCache,
              ),
            ),
      ).asyncExpand<Proposal>(
        (final snapshot) => snapshot.docs
            .where((final doc) => doc.exists)
            .map<Object?>((final doc) => doc.data())
            .whereType<Map<String, Object?>>()
            .mapJsonLogException<Proposal?>(Proposal.fromJson)
            .whereType<Proposal>()
            .convert(),
      );

  @override
  Stream<ProposalChange> subscribeOnRecent({
    required DateTime updatedAfter,
  }) =>
      _feedCollection
          .where(
            'updated',
            isGreaterThan: DateUtil.toTimestamp(updatedAfter),
          )
          .orderBy(
            'updated',
            descending: false,
          )
          .snapshots(
            includeMetadataChanges: true,
          )
          .map<List<DocumentChange<Object?>>>((snapshot) => snapshot.docChanges)
          .asyncExpand<ProposalChange>((changes) async* {
        l.i('Получено сообщение об изменении ленты');
        final stopwatch = Stopwatch()..start();
        for (final change in changes) {
          try {
            if (stopwatch.elapsedMilliseconds > 16) {
              await Future<void>.delayed(Duration.zero);
              stopwatch.reset();
            }
            final data = change.doc.data();
            if (data is! Map<String, Object?>) continue;
            final proposal = Proposal.fromJson(data);
            if (proposal.disabled) {
              yield ProposalRemoved(proposal);
            } else {
              switch (change.type) {
                case DocumentChangeType.added:
                  yield ProposalAdded(proposal);
                  break;
                case DocumentChangeType.modified:
                  yield ProposalModified(proposal);
                  break;
                case DocumentChangeType.removed:
                  yield ProposalRemoved(proposal);
                  break;
              }
            }
          } on Object catch (err) {
            l.w('Ошибка разбора документа firebase: $err');
          }
        }
        stopwatch.stop();
      });

  @override
  Stream<Proposal<Attribute>> paginate({
    required final DateTime updatedBefore,
    required final int count,
  }) =>
      Stream<QuerySnapshot<Object?>>.fromFuture(
        _feedCollection
            .where(
              'updated',
              isLessThan: DateUtil.toTimestamp(updatedBefore),
            )
            .orderBy(
              'updated',
              descending: true,
            )
            .limit(count)
            .get(
              const GetOptions(
                source: Source.serverAndCache,
              ),
            ),
      ).asyncExpand<Proposal>(
        (final snapshot) => snapshot.docs
            .where((final doc) => doc.exists)
            .map<Object?>((final doc) => doc.data())
            .whereType<Map<String, Object?>>()
            .mapJsonLogException<Proposal?>(Proposal.fromJson)
            .whereType<Proposal>()
            .convert(),
      );

  @override
  Future<Proposal<Attribute>?> getById({required final String id}) async {
    DocumentSnapshot<Object?> snapshot;
    try {
      snapshot = await _feedCollection.doc('id').get(
            const GetOptions(
              source: Source.serverAndCache,
            ),
          );
      // ignore: avoid_catching_errors
    } on StateError {
      return null;
    }
    if (!snapshot.exists) return null;
    final data = snapshot.data();
    if (data is! Map<String, Object?>) return null;
    return Proposal.fromJson(data);
  }
}

extension on Iterable<Map<String, Object?>> {
  Iterable<R?> mapJsonLogException<R extends Object?>(final R Function(Map<String, Object?>) convert) => map<R?>(
        (final json) {
          try {
            return convert(json);
          } on Object catch (exception, stackTrace) {
            l.w(exception, stackTrace);

            /// TODO: заменить на класс FeedException для последующего вывода плиток с ошибками
            return null;
          }
        },
      );
}
