import 'dart:math' as math show Random;

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/utils/date_util.dart';
import '../model/proposal.dart';

// ignore: one_member_abstracts
abstract class IFeedRepository {
  Stream<Proposal> paginate({
    required final int count,
    required final DateTime createdBefore,
  });
}

class FeedRepositoryFirebase implements IFeedRepository {
  /// Коллекция
  final CollectionReference _collection;

  FeedRepositoryFirebase({
    required final FirebaseFirestore firestore,
  }) : _collection = firestore.collection('feed');

  @override
  Stream<Proposal> paginate({
    required final int count,
    required final DateTime createdBefore,
  }) =>
      Stream<QuerySnapshot<Object?>>.fromFuture(
        _collection
            .where(
              'created',
              isLessThan: DateUtil.dateToUnixTime(createdBefore),
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
      ).expand<Proposal>(
        (snapshot) => snapshot.docs
            .where((doc) => doc.exists)
            .map<Object?>((doc) => doc.data())
            .whereType<Map<String, Object?>>()
            .map((data) => Proposal.fromJson(data)),
      );
}

class FeedRepositoryFake implements IFeedRepository {
  static math.Random get _rnd => __rnd ??= math.Random();
  static math.Random? __rnd;
  FeedRepositoryFake();

  @override
  Stream<Proposal> paginate({
    required final int count,
    required final DateTime createdBefore,
  }) {
    var lastDate = createdBefore;
    return Stream<Proposal>.periodic(
      const Duration(milliseconds: 150),
      (i) {
        lastDate = lastDate.subtract(Duration(seconds: _rnd.nextInt(60 * 60 * 24)));
        return Job(
          id: lastDate.millisecondsSinceEpoch.toRadixString(36),
          title: 'Job #${lastDate.millisecondsSinceEpoch * 1000 + i}',
          created: lastDate,
          updated: lastDate,
        );
      },
    ).take(count);
  }
}
