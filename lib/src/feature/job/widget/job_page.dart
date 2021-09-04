import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../bloc/job_bloc.dart';
import '../model/job.dart';
import 'job_screen.dart';

class JobPage extends Page<void> {
  final String id;
  const JobPage({
    required final this.id,
  });

  @override
  Route<void> createRoute(BuildContext context) => MaterialPageRoute(
        builder: (context) => BlocScope.create(
          create: (context) => JobBLoC(
            initialState: JobState.fetching(
              job: Job(
                id: id,
                updated: DateTime.now(),
                created: DateTime.now(),
                data: null,
              ),
            ),
          )..add(const JobEvent.fetch()),
          child: const JobScreen(),
        ),
        settings: this,
      );
}
