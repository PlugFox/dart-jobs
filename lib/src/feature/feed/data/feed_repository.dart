import 'dart:async';
import 'dart:math' as math show Random;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:l/l.dart';

import '../../../common/model/proposal.dart';
import '../../../common/utils/date_util.dart';
import '../../../common/utils/iterable_to_stream_coverter.dart';

// ignore: one_member_abstracts
abstract class IFeedRepository {
  Stream<Proposal> fetchRecent({
    required final DateTime updatedAfter,
  });

  Stream<Proposal> paginate({
    required final DateTime updatedBefore,
    required final int count,
  });
}

class FeedRepositoryFirebase implements IFeedRepository {
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
  Stream<Proposal> paginate({
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

class FeedRepositoryFake implements IFeedRepository {
  static math.Random get _rnd => __rnd ??= math.Random();
  static math.Random? __rnd;
  FeedRepositoryFake();

  @override
  Stream<Proposal<Attribute>> fetchRecent({
    required DateTime updatedAfter,
  }) {
    var lastDate = updatedAfter;
    return Stream<Proposal>.periodic(
      const Duration(milliseconds: 150),
      (i) {
        lastDate = lastDate.add(Duration(seconds: _rnd.nextInt(60 * 60)));
        return Job(
          id: lastDate.millisecondsSinceEpoch.toRadixString(36),
          creatorId: '<creatorId>',
          title: 'Job #${lastDate.millisecondsSinceEpoch * 1000 + i}',
          created: lastDate,
          updated: lastDate,
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
        return Job(
          id: lastDate.millisecondsSinceEpoch.toRadixString(36),
          creatorId: '<creatorId>',
          title: 'Job #${lastDate.millisecondsSinceEpoch * 1000 + i}',
          created: lastDate,
          updated: lastDate,
        );
      },
    ).take(count);
  }
}
