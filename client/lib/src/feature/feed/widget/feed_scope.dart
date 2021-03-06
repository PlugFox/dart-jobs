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

  /// Запросить обновление
  static void fetchRecentOf(final BuildContext context) => BlocProvider.of<FeedBLoC>(
        context,
        listen: false,
      )..add(const FeedEvent.fetchRecent());

  /// Запросить следующую порцию данных
  static void paginateOf(final BuildContext context) => BlocProvider.of<FeedBLoC>(
        context,
        listen: false,
      )..add(const FeedEvent.paginate());

  /// Установить фильтр
  static void setFilterOf(final BuildContext context, JobFilter Function(JobFilter filter) updateFilter) {
    final bloc = BlocProvider.of<FeedBLoC>(
      context,
      listen: false,
    );
    bloc.add(
      FeedEvent.setFilter(
        updateFilter(bloc.state.filter),
      ),
    );
  }

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
  static void createJobOf(final BuildContext context) {
    final router = AppRouter.of(context).router;
    AuthenticationScope.authenticateOr(
      context,
      (_) => router.setNewRoutePath(
        const JobRouteConfiguration.create(),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) => BlocProvider<FeedBLoC>(
        create: (final context) => FeedBLoC(
          repository: RepositoryScope.of(context).jobRepository,
        ),
        child: child,
      );
}
