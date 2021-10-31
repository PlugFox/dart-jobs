import 'package:dart_jobs/src/feature/not_found/widget/not_found_screen.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends Page<void> {
  const NotFoundPage()
      : super(
          key: const ValueKey<String>('/404'),
          name: '/404',
          arguments: const <String, Object?>{},
        );

  @override
  Route<void> createRoute(final BuildContext context) => MaterialPageRoute<void>(
        builder: (final context) => const NotFoundScreen(),
        settings: this,
      );
}
