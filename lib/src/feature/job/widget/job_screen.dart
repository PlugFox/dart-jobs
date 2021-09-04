import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../bloc/job_bloc.dart';

@immutable
class JobScreen extends StatelessWidget {
  const JobScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: BlocBuilder<JobBLoC, JobState>(
            builder: (context, state) => state.when<Widget>(
              fetching: (job) => Text('Job loading...'),
              filled: (job) => Text('Job #${job.id}'),
              error: (job, message) => Text('Job error'),
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<JobBLoC, JobState>(
            builder: (context, state) => state.when<Widget>(
              fetching: (job) => const Center(child: CircularProgressIndicator()),
              filled: (job) => Text(job.id),
              error: (job, message) => Center(child: Text(message)),
            ),
          ),
        ),
      );
}
