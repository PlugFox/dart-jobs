import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_form.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class JobScreen extends StatelessWidget {
  const JobScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => JobForm(
        bloc: BlocProvider.of<JobBLoC>(context, listen: false),
        child: BlocListener<JobBLoC, JobState>(
          listener: (context, state) => state.maybeMap<void>(
            orElse: () {},
            saved: (saved) {},
          ),
          child: BlocBuilder<JobBLoC, JobState>(
            builder: (context, state) => state.maybeMap(
              orElse: () => Scaffold(
                appBar: AppBar(
                  title: Text(
                    state.job.data.title,
                    maxLines: 1,
                  ),
                ),
                body: const SafeArea(
                  child: Center(
                    child: JobFormFieldSet(),
                  ),
                ),
              ),
              notFound: (_) => const JobNotFound(),
            ),
          ),
        ),
      );
}
