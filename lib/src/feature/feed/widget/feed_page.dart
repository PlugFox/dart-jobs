import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../common/router/root_route.dart';
import 'feed_screen.dart';

class FeedPage extends Page<void> {
  const FeedPage();

  @override
  Route<void> createRoute(BuildContext context) => RootRoute(
        builder: (context) => const FeedScreen(),
        settings: this,
      );
}
