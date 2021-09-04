import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'settings_screen.dart';

class SettingsPage extends Page<void> {
  const SettingsPage();

  @override
  Route<void> createRoute(BuildContext context) => MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
        settings: this,
      );
}
