import 'package:dart_jobs_client/src/feature/authentication/widget/profile_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends Page<void> {
  const ProfilePage()
      : super(
          key: const ValueKey<String>('/profile'),
          name: '/profile',
          arguments: const <String, Object?>{},
        );

  @override
  Route<void> createRoute(final BuildContext context) => MaterialPageRoute<void>(
        builder: (final context) => const ProfileScreen(),
        settings: this,
      );
}
