import 'package:dart_jobs_client/src/feature/settings/widget/settings_screen.dart';
import 'package:flutter/material.dart';

class SettingsPage extends Page<void> {
  const SettingsPage()
      : super(
          key: const ValueKey<String>('/settings'),
          name: '/settings',
          arguments: const <String, Object?>{},
        );

  @override
  Route<void> createRoute(final BuildContext context) => MaterialPageRoute<void>(
        builder: (final context) => const SettingsScreen(),
        settings: this,
      );
}
