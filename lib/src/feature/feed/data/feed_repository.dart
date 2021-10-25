import 'dart:async';
import 'dart:math' as math show Random;

import 'package:dart_jobs/src/common/model/proposal.dart';
import 'package:dart_jobs/src/common/model/proposal_change.dart';
import 'package:dart_jobs/src/common/utils/list_unique.dart';
import 'package:dart_jobs/src/common/utils/money_util.dart';
import 'package:dart_jobs/src/feature/feed/data/feed_network_data_provider.dart';

// ignore: one_member_abstracts
abstract class IFeedRepository {
  /// Получить по идентификатору
  /// Если возвращает null - элемент не найден, вероятно удален
  Future<Proposal?> getById({
    required final String id,
  });

  /// Запросить новейшие, стрим заканчивается после десериализации всех элементов
  Stream<Proposal> fetchRecent({
    required final DateTime updatedAfter,
  });

  /// Подписка на последние события
  /// Стрим не заканчивается, элементы выбираются при появлении их в фаербейзе
  Stream<ProposalChange> subscribeOnRecent({
    required final DateTime updatedAfter,
  });

  /// Запросить порцию старых, стрим заканчивается после десериализации всех элементов
  Stream<Proposal> paginate({
    required final DateTime updatedBefore,
    required final int count,
  });

  /// Обработать, очистить, избавиться от дубликатов, удаленных, упорядочить список
  Stream<Proposal> sanitize(final List<Proposal> proposal);
}

class FeedRepositoryFirebase with ProposalsSanitizerMixin implements IFeedRepository {
  final IFeedNetworkDataProvider _networkDataProvider;
  FeedRepositoryFirebase({
    required final IFeedNetworkDataProvider networkDataProvider,
  }) : _networkDataProvider = networkDataProvider;

  @override
  Future<Proposal<Attribute>?> getById({
    required String id,
  }) =>
      _networkDataProvider.getById(id: id);

  @override
  Stream<Proposal<Attribute>> fetchRecent({
    required DateTime updatedAfter,
  }) =>
      _networkDataProvider.fetchRecent(updatedAfter: updatedAfter);

  @override
  Stream<ProposalChange> subscribeOnRecent({
    required DateTime updatedAfter,
  }) =>
      _networkDataProvider.subscribeOnRecent(updatedAfter: updatedAfter);

  @override
  Stream<Proposal<Attribute>> paginate({
    required DateTime updatedBefore,
    required int count,
  }) =>
      _networkDataProvider.paginate(
        updatedBefore: updatedBefore,
        count: count,
      );
}

class FeedRepositoryFake with ProposalsSanitizerMixin implements IFeedRepository {
  static math.Random get _rnd => __rnd ??= math.Random();
  static math.Random? __rnd;
  FeedRepositoryFake();

  @override
  Future<Proposal<Attribute>?> getById({required final String id}) => Future<Proposal<Attribute>?>.value(null);

  @override
  Stream<Proposal<Attribute>> fetchRecent({
    required final DateTime updatedAfter,
  }) {
    var lastDate = updatedAfter;
    return Stream<Proposal>.periodic(
      const Duration(milliseconds: 150),
      (final i) {
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
          remote: _rnd.nextBool(),
          salaryFrom: MoneyUtil.zeroMoney,
          salaryTo: MoneyUtil.zeroMoney,
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
      (final i) {
        lastDate = lastDate.subtract(Duration(seconds: _rnd.nextInt(60 * 60 * 24)));
        final id = (lastDate.millisecondsSinceEpoch * 1000 + i).toRadixString(36);
        return Job(
          id: lastDate.millisecondsSinceEpoch.toRadixString(36),
          creatorId: '<creatorId>',
          created: lastDate,
          updated: lastDate,
          title: '<title #$id>',
          company: '<company #$id>',
          country: '<country #$id>',
          location: '<location #$id>',
          remote: _rnd.nextBool(),
          salaryFrom: MoneyUtil.zeroMoney,
          salaryTo: MoneyUtil.zeroMoney,
        );
      },
    ).take(count);
  }

  @override
  Stream<ProposalChange> subscribeOnRecent({required DateTime updatedAfter}) => const Stream.empty();
}

mixin ProposalsSanitizerMixin implements IFeedRepository {
  @override
  Stream<Proposal<Attribute>> sanitize(final List<Proposal<Attribute>> proposal) {
    proposal.sort((final a, final b) => b.updated.compareTo(a.updated));
    return Stream<Proposal<Attribute>>.fromIterable(proposal.unique((final p) => p.id))
        .where((proposal) => !proposal.disabled);
  }
}
