import 'dart:math';

import 'package:flame/components.dart';

import '../component/cell.dart';

class Grid {
  static Cell border = Cell(Vector2(-1, -1), -1);

  final int _rows;
  final int _columns;

  List<List<Cell>> _cells = List.empty(growable: true);

  List<List<Cell>> get cells => _cells;

  Grid(this._rows, this._columns, int cellSize) {
    _cells = List.generate(
        _rows,
        (row) => List.generate(
            _columns,
            (column) =>
                Cell(Vector2(row.toDouble(), column.toDouble()), cellSize),
            growable: false),
        growable: false);
  }

  Cell findCell(int column, int row) {
    try {
      return _cells[row][column];
    } on RangeError {
      return border;
    }
  }

  void generateFood() {
    var allCells = _cells.expand((element) => element).toList();
    var emptyCells = allCells
        .where((element) => element.cellType == CellType.empty)
        .toList();
    emptyCells[Random().nextInt(emptyCells.length)].cellType = CellType.food;
  }
}
