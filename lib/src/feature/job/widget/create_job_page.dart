import 'package:flutter/material.dart';

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
        builder: (final context) => const Placeholder(),
        settings: this,
      );
}
