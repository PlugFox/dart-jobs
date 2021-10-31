import 'package:dart_jobs/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs/src/feature/initialization/widget/initialization_scope.dart';
import 'package:dart_jobs/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs/src/feature/job/widget/job_screen.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../../../../../../shared/lib/src/models/job.dart';

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
        builder: (final context) => BlocScope<JobBLoC>.create(
          create: (context) => JobBLoC(
            repository: InitializationScope.storeOf(context).jobRepository,
            initialState: JobState.idle(
              job: FeedScope.proposalOf<Job>(
                    context,
                    (job) => job.id == id,
                  ) ??
                  Job(
                    id: id,
                    title: title,
                    creatorId: '',
                    created: DateTime.now(),
                    updated: DateTime.now(),
                  ),
            ),
          )..add(JobEvent.fetch(id)),
          child: const JobScreen(),
        ),
        settings: this,
      );
}
