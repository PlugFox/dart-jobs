import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'job_scope.dart';
import 'job_screen.dart';

class JobPage extends Page<void> {
  final String id;
  const JobPage({
    required final this.id,
  });

  @override
  Route<void> createRoute(BuildContext context) => MaterialPageRoute(
        builder: (context) => JobScope(
          id: id,
          key: ValueKey<String>(id),
          child: const JobScreen(),
        ),
        settings: this,
      );
}
