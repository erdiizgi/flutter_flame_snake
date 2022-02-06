import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_snake/snake_game.dart';

class BackGround extends PositionComponent with HasGameRef<SnakeGame> {
  static Paint white = BasicPalette.white.paint();
  static Paint blue = BasicPalette.blue.paint();

  Vector2 canvas = Vector2.zero();
  Vector2 start = Vector2.zero();
  Vector2 end = Vector2.zero();
  int cellSize = 0;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromPoints(start.toOffset(), end.toOffset()), white);
    drawVerticalLines(canvas);
    drawHorizontalLines(canvas);
  }

  void drawVerticalLines(Canvas c) {
    for (double x = start.x; x <= end.x; x += cellSize) {
      c.drawLine(Offset(x, start.y), Offset(x, end.y), blue);
    }
  }

  void drawHorizontalLines(Canvas c) {
    for (double y = start.y; y <= end.y; y += cellSize) {
      c.drawLine(Offset(start.x, y), Offset(end.x, y), blue);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    canvas = gameRef.canvasSize;
    start = gameRef.start;
    end = Vector2(canvas.x - start.x, canvas.y - start.y);
    cellSize = SnakeGame.cellSize;
  }
}
