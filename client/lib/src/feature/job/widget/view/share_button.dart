import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';

@immutable
class ShareButton extends StatelessWidget {
  const ShareButton({
    required final this.job,
    Key? key,
  }) : super(
          key: key,
        );

  final Job job;

  @override
  Widget build(BuildContext context) {
    if (job.hasNotID) return const SizedBox.shrink();

    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.share),
    );
  }
}
