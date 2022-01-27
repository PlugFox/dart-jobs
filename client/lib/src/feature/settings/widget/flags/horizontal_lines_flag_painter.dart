import 'package:flutter/material.dart';

///
/// Paints flag with amount of horizontal rectangles equal to number of colors passed
/// Hint: default flag size is 3x2
///
class HorizontalLinesFlagPainter extends CustomPainter {
  final double frameWidth;
  final double frameDiff;
  final Color frameColor;

  final List<Color> stripesColors;

  const HorizontalLinesFlagPainter({
    this.stripesColors = const <Color>[Colors.white, Colors.blue, Colors.red],
    this.frameWidth = 1,
    this.frameColor = Colors.black,
  }) : frameDiff = frameWidth / 2;

  //This method is called whenever the object needs to be repainted.
  @override
  void paint(Canvas canvas, Size size) {
    final elemH = (size.height - frameWidth) / stripesColors.length;

    //draw stripes:
    for (var i = 0; i < stripesColors.length; i++) {
      final paint = Paint()..color = stripesColors[i];
      canvas.drawRect(Rect.fromLTRB(0, i * elemH + frameDiff, size.width, (i + 1) * elemH + frameDiff), paint);
    }

    //draw frame:
    if (frameWidth > 0) {
      final paintFrame = Paint()
        ..color = frameColor
        ..strokeWidth = frameWidth
        ..strokeCap = StrokeCap.round;
      canvas
        ..drawLine(Offset.zero, Offset(0, size.height), paintFrame)
        ..drawLine(Offset.zero, Offset(size.width, 0), paintFrame)
        ..drawLine(Offset(size.width, size.height), Offset(0, size.height), paintFrame)
        ..drawLine(Offset(size.width, size.height), Offset(size.width, 0), paintFrame);
    }
  }

  //This method is called when a new instance of the class is provided.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
