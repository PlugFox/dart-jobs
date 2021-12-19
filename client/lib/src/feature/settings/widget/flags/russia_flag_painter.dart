import 'dart:ui';

import 'package:dart_jobs_client/src/feature/settings/widget/flags/horizontal_lines_flag_painter.dart';

class RussiaFlagPainter extends HorizontalLinesFlagPainter {
  const RussiaFlagPainter({
    final double frameWidth = 1,
    final Color frameColor = const Color(0xFF000000),
  }) : super(
          frameWidth: frameWidth,
          frameColor: frameColor,
          stripesColors: const <Color>[
            _white,
            _blue,
            _red,
          ],
        );

  static const _white = Color(0xFFFFFFFF);
  static const _blue = Color(0xFF0000FF);
  static const _red = Color(0xFFFF0000);
}
