import 'dart:ui';

import 'package:flame/palette.dart';

class Styles {
  static Paint white = BasicPalette.white.paint();
  static Paint blue = BasicPalette.blue.paint();
  static Paint red = BasicPalette.red.paint();

  static Paint snakeBody = BasicPalette.black.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

  static Paint gameOver = BasicPalette.red.paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;
}
