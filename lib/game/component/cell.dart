import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter_flame_snake/game/snake_game.dart';

import '../entity/food.dart';
import '../entity/snake_body.dart';

enum CellType { empty, snakeBody, food }

class Cell extends PositionComponent with HasGameRef<SnakeGame> {

  static Cell zero = Cell(Vector2(0, 0), 0);

  final Vector2 _index;
  final int _cellSize;
  CellType cellType;
  Vector2 _location = Vector2.zero();

  int get row => _index.x.toInt();

  int get column => _index.y.toInt();

  Vector2 get index => _index;

  Vector2 get location => _location;

  Cell(this._index, this._cellSize, {this.cellType = CellType.empty});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var start = gameRef.offSets.start;
    _location = Vector2(
        column * _cellSize + start.x, row * _cellSize + start.y);
  }

  @override
  void render(Canvas canvas) {
    // TODO get rid of switch by making the cell type an object and directly call render on it.
    switch (cellType) {
      case CellType.snakeBody:
        SnakeBody.render(canvas, _location, _cellSize);
        break;
      case CellType.food:
        Food.render(canvas, _location, _cellSize);
        break;
      case CellType.empty:
        break;
    }
  }
}
