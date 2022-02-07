import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_snake/game/config/styles.dart';
import 'package:flutter_flame_snake/game/snake_game.dart';

class BackGround extends PositionComponent with HasGameRef<SnakeGame> {

  Offset start = Offset.zero;
  Offset end = Offset.zero;

  final int cellSize;

  BackGround(this.cellSize);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    start = gameRef.offSets.start.toOffset();
    end = gameRef.offSets.end.toOffset();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromPoints(start, end), Styles.white);
    _drawVerticalLines(canvas);
    _drawHorizontalLines(canvas);
  }

  void _drawVerticalLines(Canvas c) {
    for (double x = start.dx; x <= end.dx; x += cellSize) {
      c.drawLine(Offset(x, start.dy), Offset(x, end.dy), Styles.blue);
    }
  }

  void _drawHorizontalLines(Canvas c) {
    for (double y = start.dy; y <= end.dy; y += cellSize) {
      c.drawLine(Offset(start.dx, y), Offset(end.dx, y), Styles.blue);
    }
  }
}
