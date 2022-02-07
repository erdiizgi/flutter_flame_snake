import 'package:flame/components.dart';
import 'package:flutter_flame_snake/game/config/game_config.dart';

class OffSets {
  Vector2 start = Vector2.zero();
  Vector2 end = Vector2.zero();

  OffSets(Vector2 canvasSize) {
    var gameAreaX = GameConfig.cellSize * GameConfig.columns;
    var gameAreaY = GameConfig.cellSize * GameConfig.rows;

    start = Vector2((canvasSize.x - gameAreaX) / 2, (canvasSize.y - gameAreaY) / 2);
    end = Vector2(canvasSize.x - start.x, canvasSize.y - start.y);
  }
}