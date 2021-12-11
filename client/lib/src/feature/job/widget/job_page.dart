import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_screen.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobPage extends Page<void> {
  JobPage({
    required final this.job,
    final this.edit = false,
  }) : super(
          key: ValueKey<String>('/job/${job.id}'),
          name: '/job/${job.id}',
          arguments: <String, Object?>{
            'job': job,
            'edit': edit,
          },
        );

  /// Работа
  final Job job;

  /// Открыть в режиме редактирования, а не просмотра
  final bool edit;

  @override
  Route<void> createRoute(final BuildContext context) => MaterialPageRoute<void>(
        builder: (final context) => BlocProvider<JobBLoC>(
          create: (context) => JobBLoC(
            repository: RepositoryScope.of(context).jobRepository,
            job: job,
          )..add(JobEvent.fetch(job.id)),
          child: const JobScreen(),
        ),
        settings: this,
      );
}
