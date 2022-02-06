import 'dart:collection';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter_flame_snake/snake_body_part.dart';
import 'package:flutter_flame_snake/snake_game.dart';

import 'cell.dart';
import 'grid.dart';

enum Direction { up, right, down, left }

class Snake extends PositionComponent with HasGameRef<SnakeGame> {
  static const initialLength = 3;
  static const fps = 5;

  static Vector2 headIndex = Vector2(3, 20);

  final LinkedList<SnakeBodyPart> snakeBody = LinkedList();
  final List<Vector2> commandQueue = [];
  final Grid grid;

  Direction direction = Direction.right;
  Cell? head;
  double dtTotal = 0;
  double targetDt = 1 / fps;
  bool gameOver = false;

  Snake(this.grid) {
    head = grid.find(headIndex.x.toInt(), headIndex.y.toInt());
    snakeBody.add(SnakeBodyPart.fromCell(head!));

    var body = grid.find(headIndex.x.toInt() - 1, headIndex.y.toInt());
    var rear = grid.find(headIndex.x.toInt() - 2, headIndex.y.toInt());
    snakeBody.add(SnakeBodyPart.fromCell(body));
    snakeBody.add(SnakeBodyPart.fromCell(rear));
  }

  @override
  void update(double dt) {
    super.update(dt);
    dtTotal += dt;

    if (dtTotal >= targetDt) {
      dtTotal = 0;
      updateSnake();
    }
  }

  void updateSnake() {
    if (!gameOver) {
      evaluateNextCommand();
      Cell nextCell = getNextCell();
      if (nextCell != Grid.border) {
        if (checkCrash(nextCell)) {
          gameOver = true;
        } else {
          if (nextCell.cellType == CellType.food) {
            grow(nextCell);
            grid.generateFood();
          } else {
            move(nextCell);
          }
        }
      } else {
        gameOver = true;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    if(gameOver) {
      Paint red = BasicPalette.red.paint();
      red.style = PaintingStyle.stroke;
      red.strokeWidth = 10;
      canvas.drawRect(
          Rect.fromLTRB(2, 2, gameRef.canvasSize.x - 2, gameRef.canvasSize.y - 2),
          red);
    }
  }

  void move(Cell nextCell) {
    snakeBody.last.cell.cellType = CellType.empty;
    snakeBody.remove(snakeBody.last);

    head = nextCell;
    head!.cellType = CellType.snakeBody;
    snakeBody.addFirst(SnakeBodyPart.fromCell(head!));
  }

  void grow(Cell nextCell) {
    nextCell.cellType = CellType.snakeBody;
    snakeBody.addFirst(SnakeBodyPart.fromCell(nextCell));
    head = nextCell;
  }

  Cell getNextCell() {
    var row = head!.row;
    var column = head!.column;

    switch (direction) {
      case Direction.up:
        row--;
        break;
      case Direction.right:
        column++;
        break;
      case Direction.down:
        row++;
        break;
      case Direction.left:
        column--;
        break;
    }
    return grid.find(column, row);
  }

  bool checkCrash(Cell nextCell) {
    for (var part in snakeBody) {
      if (part.cell == nextCell) {
        return true;
      }
    }

    return false;
  }

  void onTapUp(TapUpInfo info) {
    final touchPoint = info.eventPosition.game;
    addCommand(touchPoint);
  }

  void evaluateNextCommand() {
    if(commandQueue.isNotEmpty) {
      var touchPoint = commandQueue[0];
      commandQueue.remove(touchPoint);

      var diff = touchPoint - head!.location;
      bool isSnakeHorizontal = direction == Direction.left || direction == Direction.right;

      if(isSnakeHorizontal) {
        if(diff.y < 0) {
          direction = Direction.up;
        } else {
          direction = Direction.down;
        }
      } else {
        if(diff.x < 0) {
          direction = Direction.left;
        } else {
          direction = Direction.right;
        }
      }
    }
  }

  void addCommand(Vector2 tap) {
    if(commandQueue.length != 3) {
      commandQueue.add(tap);
    }
  }
}


