import 'package:flutter/material.dart';

import 'profile_screen.dart';

class ProfilePage extends Page<void> {
  const ProfilePage()
      : super(
          key: const ValueKey<String>('/profile'),
          name: '/profile',
          arguments: const <String, Object?>{},
        );

  @override
  Route<void> createRoute(BuildContext context) => MaterialPageRoute<void>(
        builder: (context) => const ProfileScreen(),
        settings: this,
      );
}
