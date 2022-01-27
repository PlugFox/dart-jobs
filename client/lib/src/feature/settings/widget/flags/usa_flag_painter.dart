import 'package:dart_jobs_client/src/feature/settings/widget/flags/horizontal_lines_flag_painter.dart';
import 'package:flutter/material.dart';

///
/// Usa flag painter.
/// Hint: Default USA flag size is 19x10
///
class UsaFlagPainter extends HorizontalLinesFlagPainter {
  static const usaRedColor = Color.fromRGBO(187, 19, 62, 1);
  static const usaBlueColor = Color.fromRGBO(0, 38, 100, 1);

  const UsaFlagPainter({
    final double frameWidth = 1,
    final Color frameColor = Colors.black,
  }) : super(
          frameWidth: frameWidth,
          frameColor: frameColor,
          stripesColors: const <Color>[
            usaRedColor,
            Colors.white,
            usaRedColor,
            Colors.white,
            usaRedColor,
            Colors.white,
            usaRedColor,
            Colors.white,
            usaRedColor,
            Colors.white,
            usaRedColor,
            Colors.white,
            usaRedColor,
          ],
        );

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);

    //draw blue rect of USA flag in corner:
    final starAreaWidth = (size.width * 2) / 5;
    final starAreaHeight = (size.height * 7) / 13;
    final paintBlue = Paint()..color = usaBlueColor;
    canvas.drawRect(
      Rect.fromLTRB(frameDiff, frameDiff, starAreaWidth + frameDiff, starAreaHeight + frameDiff),
      paintBlue,
    );
    //draw start:

    final starPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    for (var j = 0; j < 5; j++) {
      double addX;
      int starsAmount;
      if (j % 2 != 0) {
        addX = starAreaWidth / 12;
        starsAmount = 5;
      } else {
        addX = 0;
        starsAmount = 6;
      }
      for (var i = 0; i < starsAmount; i++) {
        final path = getStarPath(
          starAreaWidth / 12,
          offsetX: starAreaWidth / 24 + i * starAreaWidth / 6 + addX,
          offsetY: starAreaHeight / 20 + j * starAreaHeight / 5,
        );
        canvas.drawPath(path, starPaint);
      }
    }
  }

  Path getStarPath(double starSize, {double offsetX = 0, double offsetY = 0}) {
    final path = Path()
      ..moveTo(offsetX + starSize / 2, offsetY + 0) // init point
      ..lineTo(offsetX + starSize * 34 / 55, offsetY + starSize * 80 / 210)
      ..lineTo(offsetX + starSize, offsetY + starSize * 80 / 210)
      ..lineTo(offsetX + starSize * 152 / 220, offsetY + starSize * 128 / 210)
      ..lineTo(offsetX + starSize * 178 / 220, offsetY + starSize)
      ..lineTo(offsetX + starSize * 110 / 220, offsetY + starSize * 160 / 210)
      ..lineTo(offsetX + starSize * 42 / 220, offsetY + starSize)
      ..lineTo(offsetX + starSize * 68 / 220, offsetY + starSize * 128 / 210)
      ..lineTo(offsetX + 0, offsetY + starSize * 80 / 210)
      ..lineTo(offsetX + starSize * 84 / 220, offsetY + starSize * 80 / 210)
      ..lineTo(offsetX + starSize / 2, offsetY + 0)
      ..close();
    return path;
  }
}
