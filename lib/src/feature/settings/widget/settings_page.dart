import 'package:flutter/material.dart';

import 'settings_screen.dart';

class SettingsPage extends Page<void> {
  const SettingsPage()
      : super(
          key: const ValueKey<String>('/settings'),
          name: '/settings',
          arguments: const <String, Object?>{},
        );

  @override
  Route<void> createRoute(BuildContext context) => MaterialPageRoute<void>(
        builder: (context) => const SettingsScreen(),
        settings: this,
      );
}
