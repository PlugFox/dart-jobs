import 'dart:math' as math;

import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_create_screen.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          authenticated: (user) => BlocProvider<JobBLoC>(
            create: (context) => JobBLoC.creation(
              repository: RepositoryScope.of(context).jobRepository,
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
