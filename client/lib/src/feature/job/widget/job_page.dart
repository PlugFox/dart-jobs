import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/pages.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/common/widget/adaptive_scaffold.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_form.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_not_found.dart';
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
    return id is int ? _JobScreen(id: id) : const _JobCreateScreen();
  }
}

@immutable
class _JobScreen extends StatelessWidget {
  const _JobScreen({
    required final this.id,
    Key? key,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) => BlocProvider<JobBLoC>(
        create: (context) => JobBLoC(
          repository: RepositoryScope.of(context).jobRepository,
          job: FeedScope.jobOf(context, (j) => j.id == id) ?? Job.id(id),
        )..add(const JobEvent.fetch()),
        child: Builder(
          builder: (context) => JobForm(
            bloc: BlocProvider.of<JobBLoC>(context, listen: false),
            child: BlocListener<JobBLoC, JobState>(
              listener: (context, state) => state.maybeMap<void>(
                orElse: () {},
                saved: (saved) {},
              ),
              child: BlocBuilder<JobBLoC, JobState>(
                builder: (context, state) => state.maybeMap(
                  orElse: () => AdaptiveScaffold(
                    appBar: AppBar(
                      leading: const BackButton(),
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
          ),
        ),
      );
}

@immutable
class _JobCreateScreen extends StatelessWidget {
  const _JobCreateScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AuthenticationScope.userOf(context).when(
        authenticated: (user) => BlocProvider<JobBLoC>(
          create: (context) => JobBLoC.creation(
            repository: RepositoryScope.of(context).jobRepository,
          ),
          child: BlocListener<JobBLoC, JobState>(
            listener: (context, state) => state.maybeMap<void>(
              orElse: () {},
              saved: (saved) => AppRouter.navigate(
                context,
                (configuration) => JobRouteConfiguration(saved.job.id),
              ),
            ),
            child: Builder(
              builder: (context) => JobForm(
                bloc: BlocProvider.of<JobBLoC>(context, listen: false),
                child: AdaptiveScaffold(
                  appBar: AppBar(
                    leading: const BackButton(),
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
            ),
          ),
        ),
        notAuthenticated: () => const JobNotFound(),
      );
}

/*
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
 */
