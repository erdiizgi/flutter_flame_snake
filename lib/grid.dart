import 'dart:math';

import 'cell.dart';

class Grid {
  static Cell border = Cell(-1, -1);

  int rows;
  int columns;

  List<List<Cell>> _cells = List.empty(growable: true);

  List<List<Cell>> get cells => _cells;

  Grid(this.rows, this.columns) {
    _cells = List.generate(
        rows, (r) => List.generate(columns, (c) => Cell(r, c), growable: false),
        growable: false);
  }

  Cell find(int column, int row) {
    try {
      return _cells[row][column];
    }
    on RangeError {
      return border;
    }
  }

  void generateFood() {
    var allCells = _cells.expand((element) => element).toList();
    var emptyCells = allCells.where((element) => element.cellType == CellType.empty).toList();
    var i = Random().nextInt(emptyCells.length);
    emptyCells[i].cellType = CellType.food;
  }

  void generateFoodDebug() {
    _cells[20][6].cellType = CellType.food;
  }
}
