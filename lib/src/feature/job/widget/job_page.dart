import 'package:flutter/material.dart';

import '../../authentication/widget/authentication_scope.dart';
import 'job_scope.dart';
import 'job_screen.dart';

class JobPage extends Page<void> {
  JobPage({
    required final this.id,
    required final this.title,
    final this.edit = false,
  }) : super(
          key: ValueKey<String>('/job/id$id'),
          name: '/job/id$id',
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
  Route<void> createRoute(BuildContext context) => MaterialPageRoute<void>(
        builder: (context) => JobScope(
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
