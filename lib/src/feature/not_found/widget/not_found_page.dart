import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'not_found_screen.dart';

class NotFoundPage extends Page<void> {
  const NotFoundPage()
      : super(
          key: const ValueKey<String>('/404'),
          name: '/404',
          arguments: const <String, Object?>{},
        );

  @override
  Route<void> createRoute(BuildContext context) => MaterialPageRoute<void>(
        builder: (context) => const NotFoundScreen(),
        settings: this,
      );
}
