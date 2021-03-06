import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/common/widget/adaptive_scaffold.dart';
import 'package:dart_jobs_client/src/common/widget/error_snackbar.dart';
import 'package:dart_jobs_client/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_edit_form.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';

@immutable
class JobEditFlow extends StatelessWidget {
  JobEditFlow({
    required this.user,
    required this.jobId,
    Key? key,
  }) : super(key: key ?? ValueKey<String>('${user.uid}_$jobId'));

  final AuthenticatedUser user;
  final int jobId;

  @override
  Widget build(BuildContext context) => BlocConsumer<JobBLoC, JobState>(
        listener: (context, state) {
          state.maybeMap<void>(
            orElse: () {},
            deleted: (_) {
              l.i('Работа была удалена на экране редактирования работы - запрашиваем обновление списка');
              FeedScope.fetchRecentOf(context);
            },
            saved: (_) {
              l.i('Работа была сохранена на экране редактирования работы - запрашиваем обновление списка');
              FeedScope.fetchRecentOf(context);
            },
          );
          if (state.job.creatorId != user.uid) {
            AppRouter.goHome(context);
          }
        },
        buildWhen: (prev, next) => next.maybeMap<bool>(
          orElse: () => prev.job.id != next.job.id,
          notFound: (_) => true,
        ),
        builder: (context, state) => state.maybeMap<Widget>(
          orElse: () => AdaptiveScaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: BlocBuilder<JobBLoC, JobState>(
                builder: (context, state) {
                  final title =
                      state.job.data.title.isEmpty ? context.localization.create_new_job : state.job.data.title;
                  return Text(
                    title,
                    maxLines: 1,
                  );
                },
              ),
            ),
            body: BlocListener<JobBLoC, JobState>(
              listener: (context, state) => state.mapOrNull<void>(
                error: (state) => ScaffoldMessenger.of(context).showSnackBar(
                  ErrorSnackBar(
                    error: state.message,
                  ),
                ),
              ),
              child: const SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FocusScope(
                    child: JobEditForm(),
                  ),
                ),
              ),
            ),
          ),
          notFound: (_) => const JobNotFound(),
        ),
      );
}
