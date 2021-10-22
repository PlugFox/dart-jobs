import 'package:dart_jobs/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs/src/feature/job/widget/job_scope.dart';
import 'package:dart_jobs/src/feature/job/widget/job_screen.dart';
import 'package:flutter/material.dart';

class JobPage extends Page<void> {
  JobPage({
    required final this.id,
    required final this.title,
    final this.edit = false,
  }) : super(
          key: ValueKey<String>('/job/$id'),
          name: '/job/$id',
          arguments: <String, Object?>{
            'id': id,
            'edit': edit,
          },
        );

  /// Идентификатор работы
  final String id;

  /// Заголовок работы
  final String title;

  /// Открыть в режиме редактирования, а не просмотра
  final bool edit;

  @override
  Route<void> createRoute(final BuildContext context) => MaterialPageRoute<void>(
        builder: (final context) => JobScope(
          key: ValueKey<String>('job_scope_$id'),
          id: id,
          creatorId: edit ? AuthenticationScope.userOf(context).authenticatedOrNull?.uid : null,
          child: JobScreen(
            id: id,
            title: title.isEmpty ? id : title,
            edit: edit,
          ),
        ),
        settings: this,
      );
}
