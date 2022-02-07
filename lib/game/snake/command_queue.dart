import 'package:flame/components.dart';
import 'package:flutter_flame_snake/game/snake/snake.dart';

class CommandQueue {
  final List<Vector2> touches = [];

  add(Vector2 touchPoint) {
    if (touches.length != 3) {
      touches.add(touchPoint);
    }
  }

  void evaluateNextInput(Snake snake) {
    if (touches.isNotEmpty) {
      var touchPoint = touches[0];
      touches.remove(touchPoint);

      var delta = snake.displacementToHead(touchPoint);

      snake.direction = snake.isHorizontal()
          ? delta.y < 0
              ? Direction.up
              : Direction.down
          : delta.x < 0
              ? Direction.left
              : Direction.right;
    }
  }
}
