import 'dart:math' as math;

import 'package:dart_jobs/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs/src/feature/initialization/widget/initialization_scope.dart';
import 'package:dart_jobs/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs/src/feature/job/widget/job_create_screen.dart';
import 'package:dart_jobs/src/feature/job/widget/job_not_found.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../../../../../../shared/lib/src/models/job.dart';

class JobCreatePage extends Page<void> {
  JobCreatePage()
      : super(
          key: const ValueKey<String>('/job/'),
          name: '/job/',
          arguments: <String, Object?>{
            'edit': true,
          },
        );

  @override
  Route<void> createRoute(final BuildContext context) => MaterialPageRoute<void>(
        builder: (final context) => AuthenticationScope.userOf(context).when(
          authenticated: (user) => BlocScope<JobBLoC>.create(
            create: (context) => JobBLoC(
              repository: InitializationScope.storeOf(context).jobRepository,
              initialState: JobState.idle(
                job: Job.create(
                  creatorId: user.uid,
                  title: _WorkTitleRandomizer.instance().next(),
                ),
              ),
            ),
            child: const JobCreateScreen(),
          ),
          notAuthenticated: () => const JobNotFound(),
        ),
        settings: this,
      );
}

// ignore: unused_element
class _WorkTitleRandomizer {
  _WorkTitleRandomizer._();
  static _WorkTitleRandomizer? _instance;
  // ignore: unused_element
  factory _WorkTitleRandomizer.instance() => _instance ??= _WorkTitleRandomizer._();
  static const List<String> _variants = <String>[
    'Best work ever',
    "Let's work together",
    'Dart developer required',
    'Most wanted',
    'Payment by cookies',
    'Hiring for everyone',
    'Dart goez fasta, brrr',
  ];
  final math.Random _rnd = math.Random();
  final int _max = _variants.length - 1;
  String next() => _variants[_rnd.nextInt(_max)];
}
