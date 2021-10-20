import 'dart:async';
import 'dart:math' as math show Random;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:l/l.dart';

import '../../../common/model/proposal.dart';
import '../../../common/utils/date_util.dart';
import '../../../common/utils/iterable_to_stream_coverter.dart';
import '../../../common/utils/list_unique.dart';

// ignore: one_member_abstracts
abstract class IFeedRepository {
  /// Получить по идентификатору
  /// Если возвращает null - элемент не найден, вероятно удален
  Future<Proposal?> getById({
    required final String id,
  });

  /// Запросить новейшие
  Stream<Proposal> fetchRecent({
    required final DateTime updatedAfter,
  });

  /// Запросить порцию старых
  Stream<Proposal> paginate({
    required final DateTime updatedBefore,
    required final int count,
  });

  /// Обработать, очистить, избавиться от дубликатов, удаленных, упорядочить список
  Stream<Proposal> sanitize(List<Proposal> proposal);
}

class FeedRepositoryFirebase with ProposalsSanitizerMixin implements IFeedRepository {
  /// Коллекция
  final CollectionReference _collection;

  FeedRepositoryFirebase({
    required final FirebaseFirestore firestore,
  }) : _collection = firestore.collection('feed');

  @override
  Stream<Proposal<Attribute>> fetchRecent({
    required DateTime updatedAfter,
  }) =>
      Stream<QuerySnapshot<Object?>>.fromFuture(
        _collection
            .where(
              'updated',
              isGreaterThan: DateUtil.dateToUnixTime(updatedAfter),
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
        (snapshot) => snapshot.docs
            .where((doc) => doc.exists)
            .map<Object?>((doc) => doc.data())
            .whereType<Map<String, Object?>>()
            .mapJsonLogException(Proposal.fromJson)
            .whereType<Proposal>()
            .convert(),
      );

  @override
  Stream<Proposal<Attribute>> paginate({
    required final DateTime updatedBefore,
    required final int count,
  }) =>
      Stream<QuerySnapshot<Object?>>.fromFuture(
        _collection
            .where(
              'updated',
              isLessThan: DateUtil.dateToUnixTime(updatedBefore),
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
        (snapshot) => snapshot.docs
            .where((doc) => doc.exists)
            .map<Object?>((doc) => doc.data())
            .whereType<Map<String, Object?>>()
            .mapJsonLogException(Proposal.fromJson)
            .whereType<Proposal>()
            .convert(),
      );

  @override
  Future<Proposal<Attribute>?> getById({required String id}) async {
    final snapshot = await _collection.doc('id').get(
          const GetOptions(
            source: Source.serverAndCache,
          ),
        );
    if (!snapshot.exists) return null;
    final data = snapshot.data();
    if (data is! Map<String, Object?>) return null;
    return Proposal.fromJson(data);
  }
}

extension on Iterable<Map<String, Object?>> {
  Iterable<R?> mapJsonLogException<R extends Object?>(R Function(Map<String, Object?>) covert) => map<R?>(
        (json) {
          try {
            return covert(json);
          } on Object catch (exception, stackTrace) {
            l.w(exception, stackTrace);

            /// TODO: заменить на класс ExceptionProposal для последующего вывода плиток с ошибками
            return null;
          }
        },
      );
}

class FeedRepositoryFake with ProposalsSanitizerMixin implements IFeedRepository {
  static math.Random get _rnd => __rnd ??= math.Random();
  static math.Random? __rnd;
  FeedRepositoryFake();

  @override
  Future<Proposal<Attribute>?> getById({required String id}) => Future<Proposal<Attribute>?>.value(null);

  @override
  Stream<Proposal<Attribute>> fetchRecent({
    required DateTime updatedAfter,
  }) {
    var lastDate = updatedAfter;
    return Stream<Proposal>.periodic(
      const Duration(milliseconds: 150),
      (i) {
        lastDate = lastDate.add(Duration(seconds: _rnd.nextInt(60 * 60)));
        final id = (lastDate.millisecondsSinceEpoch * 1000 + i).toRadixString(36);
        return Job(
          id: lastDate.millisecondsSinceEpoch.toRadixString(36),
          creatorId: '<creatorId>',
          created: lastDate,
          updated: lastDate,
          title: '<title #$id>',
          company: '<company #$id>',
          location: '<location #$id>',
          salary: '<salary #$id>',
        );
      },
    ).take(_rnd.nextInt(5));
  }

  @override
  Stream<Proposal> paginate({
    required final DateTime updatedBefore,
    required final int count,
  }) {
    var lastDate = updatedBefore;
    return Stream<Proposal>.periodic(
      const Duration(milliseconds: 150),
      (i) {
        lastDate = lastDate.subtract(Duration(seconds: _rnd.nextInt(60 * 60 * 24)));
        final id = (lastDate.millisecondsSinceEpoch * 1000 + i).toRadixString(36);
        return Job(
          id: lastDate.millisecondsSinceEpoch.toRadixString(36),
          creatorId: '<creatorId>',
          created: lastDate,
          updated: lastDate,
          title: '<title #$id>',
          company: '<company #$id>',
          location: '<location #$id>',
          salary: '<salary #$id>',
        );
      },
    ).take(count);
  }
}

mixin ProposalsSanitizerMixin implements IFeedRepository {
  @override
  Stream<Proposal<Attribute>> sanitize(List<Proposal<Attribute>> proposal) {
    proposal.sort((a, b) => b.updated.compareTo(a.updated));
    return Stream<Proposal<Attribute>>.fromIterable(proposal.unique((p) => p.id));
  }
}
