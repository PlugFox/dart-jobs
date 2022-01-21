import 'package:dart_jobs_client/src/common/router/pages.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_edit_flow.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_not_found.dart';
import 'package:dart_jobs_client/src/feature/job/widget/view/job_view.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Страница работы
class JobPage extends AppPage<void> {
  JobPage(String name, [String? id])
      : super(
          location: name,
          name: name,
          arguments: id,
        );

  @override
  Widget builder(BuildContext context) {
    final arg = arguments;
    final id = arg is String ? int.tryParse(arg) : null;

    if (id == null) {
      // Если id не передано - начнем создание новой работы
      // Если пользователь аутентифицирован - подготавливаем создание новой работы из шаблона
      // Если пользователь не аутентифицирован - возвращаем на главную страницу
      return AuthenticationScope.userOf(context, listen: true).when(
        authenticated: (user) => BlocProvider<JobBLoC>(
          create: (context) => JobBLoC.creation(
            repository: RepositoryScope.of(context).jobRepository,
          ),
          child: const _JobScreen(),
        ),
        notAuthenticated: () {
          WidgetsBinding.instance?.addPostFrameCallback(
            (_) => AppRouter.goHome(context),
          );
          return const JobNotFound();
        },
      );
    }
    return BlocProvider<JobBLoC>(
      create: (context) => JobBLoC(
        repository: RepositoryScope.of(context).jobRepository,
        job: FeedScope.jobOf(context, (j) => j.id == id) ?? Job.id(id),
      )..add(const JobEvent.fetch()),
      child: const _JobScreen(),
    );
  }
}

@immutable
class _JobScreen extends StatelessWidget {
  const _JobScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<JobBLoC, JobState>(
        buildWhen: (prev, next) => prev.job.id != next.job.id && prev.job.creatorId != next.job.creatorId,
        builder: (context, state) {
          final user = AuthenticationScope.userOf(context, listen: true).authenticatedOrNull;
          if (user != null && user.uid == state.job.creatorId) {
            return JobEditFlow(
              jobId: state.job.id,
              user: user,
            );
          }

          /// TODO: Hero анимация
          return BlocBuilder<JobBLoC, JobState>(
            builder: (context, state) => JobView(
              job: state.job,
            ),
          );
        },
      );
}
