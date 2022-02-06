import 'dart:collection';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter_flame_snake/snake_game.dart';

enum CellType { empty, snakeBody, food }

class Cell extends PositionComponent with HasGameRef<SnakeGame> {
  static Paint red = BasicPalette.red.paint();

  Vector2 index = Vector2.zero();
  Vector2 location = Vector2.zero();

  CellType cellType = CellType.empty;
  int cellSize = SnakeGame.cellSize;

  int get row => index.x.toInt();

  int get column => index.y.toInt();

  Cell(int row, int column) {
    index = Vector2(row.toDouble(), column.toDouble());
  }

  @override
  void render(Canvas canvas) {
    switch (cellType) {
      case CellType.snakeBody:
        drawSnakeBody(canvas);
        break;
      case CellType.food:
        drawFood(canvas);
        break;
      case CellType.empty:
        break;
    }
  }

  void drawSnakeBody(Canvas canvas) {
    Paint black = BasicPalette.black.paint();
    black.style = PaintingStyle.stroke;
    black.strokeWidth = 4;

    canvas.drawRect(
        Rect.fromPoints(Offset(location.x + 2, location.y + 2),
            Offset(location.x + cellSize - 2, location.y + cellSize - 2)),
        black);
  }

  void drawFood(Canvas canvas) {
    canvas.drawCircle(
        Offset(location.x + cellSize / 2, location.y + cellSize / 2),
        cellSize / 2 - 5, red);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var start = gameRef.start;
    location = Vector2(column * cellSize + start.x, row * cellSize + start.y);
  }
}
