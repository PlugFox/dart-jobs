// ignore_for_file: avoid_escaping_inner_quotes

import 'package:dart_jobs_client/src/common/router/page_router.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/feed/bloc/feed_bloc.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_shared/model.dart';
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
  }) =>
      BlocScope.of<FeedBLoC>(
        context,
        listen: false,
      )..add(const FeedEvent.paginate());

  /// Получить работу удовлетворяющую условию
  static Job? jobOf(
    final BuildContext context,
    final bool Function(Job proposal) test,
  ) =>
      BlocScope.of<FeedBLoC>(
        context,
        listen: false,
      ).state.list.firstWhereOrNull(test);

  /// Начать создание новой работы
  static void createJobOf(final BuildContext context) => AuthenticationScope.authenticateOr(
        context,
        (_) => PageRouter.navigate(
          context,
          (configuration) => JobCreatePageConfiguration(),
        ),
      );

  @override
  Widget build(final BuildContext context) => BlocScope<FeedBLoC>.create(
        create: (final context) => FeedBLoC(
          repository: RepositoryScope.of(context).jobRepository,
        ),
        child: child,
      );
}
