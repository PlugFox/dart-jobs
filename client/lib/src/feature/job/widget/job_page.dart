import 'package:dart_jobs/src/feature/initialization/widget/initialization_scope.dart';
import 'package:dart_jobs/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs/src/feature/job/widget/job_screen.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';

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
        builder: (final context) => BlocScope<JobBLoC>.create(
          create: (context) => JobBLoC(
            repository: InitializationScope.storeOf(context).jobRepository,
            job: job,
          )..add(JobEvent.fetch(job.id)),
          child: const JobScreen(),
        ),
        settings: this,
      );
}
