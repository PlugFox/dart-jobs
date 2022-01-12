import 'package:dart_jobs_client/src/feature/job/widget/edit/job_edit_form.dart';
import 'package:flutter/material.dart';

@immutable
class JobEditButtons extends StatelessWidget {
  const JobEditButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () => JobEditForm.reset(context),
        child: const Text('Click me'),
      );
}
