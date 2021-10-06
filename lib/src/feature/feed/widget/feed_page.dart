import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../common/router/root_route.dart';
import 'feed_screen.dart';

class FeedPage extends Page<void> {
  const FeedPage()
      : super(
          key: const ValueKey<String>('/'),
          name: '/',
          arguments: const <String, Object?>{},
        );

  @override
  Route<void> createRoute(BuildContext context) => RootRoute(
        builder: (context) => const FeedScreen(),
        settings: this,
      );
}
