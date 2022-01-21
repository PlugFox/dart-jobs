import 'package:dart_jobs_client/src/common/widget/adaptive_scaffold.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';

@immutable
class JobView extends StatelessWidget {
  const JobView({
    required final this.job,
    Key? key,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) => AdaptiveScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(
            job.data.title,
            maxLines: 1,
          ),
        ),
        body: const SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: FocusScope(
              child: Placeholder(),
            ),
          ),
        ),
      );
}
