import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter_flame_snake/background.dart';
import 'package:flutter_flame_snake/snake.dart';

import 'grid.dart';

class SnakeGame extends FlameGame with TapDetector {
  static const rows = 24;
  static const columns = 12;
  static const cellSize = 32;

  bool running = true;

  Grid grid = Grid(rows, columns);
  Snake? snake;
  int gameAreaX = 0;
  int gameAreaY = 0;
  Vector2 start = Vector2.zero();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    gameAreaX = cellSize * columns;
    gameAreaY = cellSize * rows;
    start = Vector2((canvasSize.x - gameAreaX) / 2, (canvasSize.y - gameAreaY) / 2);

    add(BackGround());

    for (var cells in grid.cells) {
      for (var cell in cells) {
        add(cell);
      }
    }
    grid.generateFoodDebug();

    snake = Snake(grid);
    add(snake!);
  }

  @override
  void onTapUp(TapUpInfo info) {
    snake!.onTapUp(info);
  }
}