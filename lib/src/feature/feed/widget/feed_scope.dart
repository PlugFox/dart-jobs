// ignore_for_file: avoid_escaping_inner_quotes

import 'dart:math' as math;

import 'package:dart_jobs/src/common/model/proposal.dart';
import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/feed/bloc/feed_bloc.dart';
import 'package:dart_jobs/src/feature/initialization/widget/initialization_scope.dart';
import 'package:dart_jobs/src/feature/job/bloc/job_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class FeedScope extends StatelessWidget {
  final Widget child;
  const FeedScope({
    required final this.child,
    final Key? key,
  }) : super(key: key);

  /// Запросить следующую порцию данных
  static void paginateOf(
    final BuildContext context, {
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
      idle: (final _, final endOfList) => endOfList,
    )) return;
    bloc.add(
      FeedEvent.paginate(
        count: count,
      ),
    );
  }

  /// Получить предложение удовлетворяющее условию
  static R? proposalOf<R extends Proposal>(
    final BuildContext context,
    final bool Function(R proposal) test,
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
    final BuildContext context, {
    required final AuthenticatedUser user,
    required final String title,
    required final String company,
    required final String location,
    required final String salary,
    JobAttributes attributes = const JobAttributes.empty(),
  }) =>
      BlocScope.of<JobManagerBLoC>(
        context,
        listen: false,
      ).add(
        JobManagerEvent.create(
          user: user,
          title: title, // ?? _WorkTitleRandomizer.instance().next(),
          company: company,
          location: location,
          salary: salary,
          attributes: attributes,
        ),
      );

  /// Создать новую работу и открыть для редактирования
  static void deleteJobOf(
    final BuildContext context, {
    required final AuthenticatedUser user,
    required final Job job,
  }) =>
      BlocScope.of<JobManagerBLoC>(
        context,
        listen: false,
      ).add(
        JobManagerEvent.delete(user: user, job: job),
      );

  @override
  Widget build(final BuildContext context) => BlocScope<FeedBLoC>.create(
        create: (final context) => FeedBLoC(
          repository: InitializationScope.storeOf(context).feedRepository,
        ),
        child: BlocScope<JobManagerBLoC>.create(
          create: (final context) => JobManagerBLoC(
            repository: InitializationScope.storeOf(context).jobRepository,
          ),
          child: child,
        ),
      );
}

// ignore: unused_element
class _WorkTitleRandomizer {
  _WorkTitleRandomizer._();
  static _WorkTitleRandomizer? _instance;
  // ignore: unused_element
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
