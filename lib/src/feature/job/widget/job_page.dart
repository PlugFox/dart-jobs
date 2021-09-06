import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../bloc/job_bloc.dart';
import '../model/job.dart';
import 'job_screen.dart';

class JobPage extends Page<void> {
  static final DateTime _initialDate = DateTime.utc(1970);

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
                updated: _initialDate,
                created: _initialDate,
                title: '',
              ),
            ),
          )..add(const JobEvent.fetch()),
          child: const JobScreen(),
        ),
        settings: this,
      );
}
