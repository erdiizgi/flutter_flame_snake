import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter_flame_snake/game/config/game_config.dart';
import 'package:flutter_flame_snake/game/config/styles.dart';

class Food {

  static void render(Canvas canvas, Vector2 location, int cellSize) {
    canvas.drawCircle(
        findMiddle(location, cellSize), findRadius(cellSize), Styles.red);
  }

  static Offset findMiddle(Vector2 location, int cellSize) {
    return Offset(location.x + cellSize / 2, location.y + cellSize / 2);
  }

  static double findRadius(int cellSize) {
    return cellSize / 2 - GameConfig.foodRadius;
  }
}