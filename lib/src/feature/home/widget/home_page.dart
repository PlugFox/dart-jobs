import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_screen.dart';

class HomePage extends Page<void> {
  const HomePage();

  @override
  Route<void> createRoute(BuildContext context) => RootRoute(
        builder: (context) => const HomeScreen(),
        settings: null,
      );
}

class RootRoute extends MaterialPageRoute<void> {
  RootRoute({
    required final WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(
          builder: builder,
          settings: settings,
          fullscreenDialog: false,
          maintainState: true,
        );
}
