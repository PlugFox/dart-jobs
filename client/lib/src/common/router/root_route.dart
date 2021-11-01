import 'package:flutter/material.dart';

class RootRoute extends MaterialPageRoute<void> {
  RootRoute({
    required final WidgetBuilder builder,
    RouteSettings? settings = const RouteSettings(
      name: '/',
      arguments: <String, Object>{},
    ),
  }) : super(
          builder: builder,
          settings: settings,
          fullscreenDialog: false,
          maintainState: true,
        );
}
