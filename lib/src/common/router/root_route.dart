import 'package:flutter/material.dart';

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
