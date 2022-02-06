import 'dart:collection';

import 'cell.dart';

class SnakeBodyPart extends LinkedListEntry<SnakeBodyPart> {

  Cell cell;

  SnakeBodyPart(this.cell);

  factory SnakeBodyPart.fromCell(Cell cell) {
    cell.cellType = CellType.snakeBody;
    return SnakeBodyPart(cell);
  }
}