import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter_flame_snake/game/config/game_config.dart';
import 'package:flutter_flame_snake/game/config/styles.dart';

class SnakeBody {

  static void render(Canvas canvas, Vector2 location, int cellSize) {
    canvas.drawRect(
        Rect.fromPoints(
            findStart(location, cellSize), findEnd(location, cellSize)),
        Styles.snakeBody);
  }

  static Offset findStart(Vector2 location, int cellSize) {
    return Offset(location.x + GameConfig.snakeLineThickness / 2,
        location.y + GameConfig.snakeLineThickness / 2);
  }

  static Offset findEnd(Vector2 location, int cellSize) {
    return Offset(location.x + cellSize - GameConfig.snakeLineThickness / 2,
        location.y + cellSize - GameConfig.snakeLineThickness / 2);
  }
}
