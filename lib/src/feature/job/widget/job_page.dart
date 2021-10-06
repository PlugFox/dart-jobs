import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'job_scope.dart';
import 'job_screen.dart';

class JobPage extends Page<void> {
  /// Идентификатор работы
  final String id;

  JobPage({
    required final this.id,
  }) : super(
          key: ValueKey<String>('/job/id$id'),
          name: '/job/id$id',
          arguments: <String, Object?>{
            'id': id,
          },
        );

  @override
  Route<void> createRoute(BuildContext context) => MaterialPageRoute<void>(
        builder: (context) => JobScope(
          id: id,
          key: ValueKey<String>(id),
          child: const JobScreen(),
        ),
        settings: this,
      );
}
