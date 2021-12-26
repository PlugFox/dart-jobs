// ignore_for_file: avoid_escaping_inner_quotes

import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/feed/bloc/feed_bloc.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class FeedScope extends StatelessWidget {
  const FeedScope({
    required final this.child,
    final Key? key,
  }) : super(key: key);

  final Widget child;

  /// Запросить следующую порцию данных
  static void paginateOf(
    final BuildContext context, {
    required final int count,
  }) =>
      BlocProvider.of<FeedBLoC>(
        context,
        listen: false,
      )..add(const FeedEvent.paginate());

  /// Получить работу удовлетворяющую условию
  static Job? jobOf(
    final BuildContext context,
    final bool Function(Job job) test,
  ) =>
      BlocProvider.of<FeedBLoC>(
        context,
        listen: false,
      ).state.list.firstWhereOrNull(test);

  /// Начать создание новой работы
  static void createJobOf(final BuildContext context) => AuthenticationScope.authenticateOr(
        context,
        (_) => AppRouter.navigate(
          context,
          (configuration) => const JobRouteConfiguration.create(),
        ),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider<FeedBLoC>(
        create: (final context) => FeedBLoC(
          repository: RepositoryScope.of(context).jobRepository,
        ),
        child: child,
      );
}
