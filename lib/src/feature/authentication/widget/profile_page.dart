import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'profile_screen.dart';

class ProfilePage extends Page<void> {
  const ProfilePage();

  @override
  Route<void> createRoute(BuildContext context) => MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
        settings: this,
      );
}
