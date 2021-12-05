import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/page_router.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_form.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';

@immutable
class JobCreateScreen extends StatelessWidget {
  const JobCreateScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocListener<JobBLoC, JobState>(
        listener: (context, state) => state.maybeMap<void>(
          orElse: () {},
          saved: (saved) => PageRouter.navigate(
            context,
            (configuration) => JobPageConfiguration(
              job: saved.job,
            ),
          ),
        ),
        child: JobForm(
          bloc: BlocScope.of<JobBLoC>(context, listen: false),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                context.localization.create_new_job,
                maxLines: 1,
              ),
            ),
            body: const SafeArea(
              child: Center(
                child: JobFormFieldSet(),
              ),
            ),
          ),
        ),
      );
}
