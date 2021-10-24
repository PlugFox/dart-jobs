// ignore_for_file: avoid_escaping_inner_quotes

import 'package:dart_jobs/src/common/model/proposal.dart';
import 'package:dart_jobs/src/common/router/page_router.dart';
import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/feed/bloc/feed_bloc.dart';
import 'package:dart_jobs/src/feature/initialization/widget/initialization_scope.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

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
    required final String country,
    required final String location,
    required final bool remote,
    required final Money salaryFrom,
    required final Money salaryTo,
    JobAttributes attributes = const JobAttributes.empty(),
  }) =>
      PageRouter.navigate(context, (configuration) => JobCreatePageConfiguration());

  @override
  Widget build(final BuildContext context) => BlocScope<FeedBLoC>.create(
        create: (final context) => FeedBLoC(
          repository: InitializationScope.storeOf(context).feedRepository,
        ),
        child: child,
      );
}
