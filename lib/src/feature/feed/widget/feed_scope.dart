// ignore_for_file: avoid_escaping_inner_quotes

import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/model/proposal.dart';
import '../../authentication/model/user_entity.dart';
import '../../initialization/widget/initialization_scope.dart';
import '../../job/bloc/job_manager_bloc.dart';
import '../bloc/feed_bloc.dart';

@immutable
class FeedScope extends StatelessWidget {
  final Widget child;
  const FeedScope({
    required final this.child,
    Key? key,
  }) : super(key: key);

  /// Запросить следующую порцию данных
  static void paginateOf(
    BuildContext context, {
    required final int count,
  }) {
    // ignore: close_sinks
    final bloc = BlocScope.of<FeedBLoC>(
      context,
      listen: false,
    );
    // Имеет смысл сейчас запрашивать?
    // Не имеет если достигнут конец списка
    // Не имеет если уже выполняется запрос
    if (bloc.state.maybeWhen<bool>(
      orElse: () => true,
      idle: (_, endOfList) => endOfList,
    )) return;
    bloc.add(
      FeedEvent.paginate(
        count: count,
      ),
    );
  }

  /// Получить предложение удовлетворяющее условию
  static R? proposalOf<R extends Proposal>(
    BuildContext context,
    bool Function(R proposal) test,
  ) {
    // ignore: close_sinks
    final bloc = BlocScope.of<FeedBLoC>(
      context,
      listen: false,
    );
    return bloc.state.list.whereType<R>().firstWhereOrNull(test);
  }

  /// Создать новую работу и открыть для редактирования
  static void createJobOf(
    BuildContext context, {
    required AuthenticatedUser user,
    String? title,
    JobAttributes attributes = const JobAttributes.empty(),
  }) =>
      BlocScope.of<JobManagerBLoC>(
        context,
        listen: false,
      ).add(
        JobManagerEvent.create(
          title: title ?? _WorkTitleRandomizer.instance().next(),
          user: user,
          attributes: attributes,
        ),
      );

  @override
  Widget build(BuildContext context) => BlocScope<FeedBLoC>.create(
        create: (context) => FeedBLoC(
          repository: InitializationScope.storeOf(context).feedRepository,
        ),
        child: BlocScope<JobManagerBLoC>.create(
          create: (context) => JobManagerBLoC(
            repository: InitializationScope.storeOf(context).jobRepository,
          ),
          child: child,
        ),
      );
}

class _WorkTitleRandomizer {
  _WorkTitleRandomizer._();
  static _WorkTitleRandomizer? _instance;
  factory _WorkTitleRandomizer.instance() => _instance ??= _WorkTitleRandomizer._();
  static const List<String> _variants = <String>[
    'Best work ever',
    'Let\'s work together',
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
