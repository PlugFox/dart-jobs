import 'package:dart_jobs/src/common/router/root_route.dart';
import 'package:dart_jobs/src/feature/feed/widget/feed_screen.dart';
import 'package:flutter/material.dart';

class FeedPage extends Page<void> {
  const FeedPage()
      : super(
          key: const ValueKey<String>('/'),
          name: '/',
          arguments: const <String, Object?>{},
        );

  @override
  Route<void> createRoute(final BuildContext context) => RootRoute(
        builder: (final context) => const FeedScreen(),
        settings: this,
      );
}
