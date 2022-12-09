import 'dart:io';

import 'package:collection/collection.dart';

class Position {
  int row;
  int col;

  Position({required this.row, required this.col});

  void moveLeft() => col--;
  void moveRight() => col++;
  void moveUp() => row--;
  void moveDown() => row++;

  @override
  String toString() => 'r: $row, c: $col';
}

class Bridge {
  final List<List<bool>> grid;
  final List<Position> knots;

  Bridge._(this.grid, this.knots);

  factory Bridge.filled(
      {int width = 10,
      int height = 10,
      Position? startPosition,
      int knotCount = 2}) {
    final grid = List<List<bool>>.generate(
        height, (_) => List<bool>.filled(width, false));
    final knots = List<Position>.generate(
        knotCount,
        (index) => startPosition != null
            ? Position(col: startPosition.col, row: startPosition.row)
            : Position(col: width ~/ 2, row: height ~/ 2));

    return Bridge._(grid, knots);
  }

  int get rows => grid.length;
  int get cols => grid[0].length;

  Position get head => knots.first;
  Position get tail => knots.last;

  bool isAdjacent(Position a, Position b) {
    return (a.row == b.row && a.col == b.col) ||
        (a.row + 1 == b.row && a.col == b.col) ||
        (a.row - 1 == b.row && a.col == b.col) ||
        (a.row == b.row && a.col + 1 == b.col) ||
        (a.row == b.row && a.col - 1 == b.col) ||
        (a.row + 1 == b.row && a.col + 1 == b.col) ||
        (a.row + 1 == b.row && a.col - 1 == b.col) ||
        (a.row - 1 == b.row && a.col + 1 == b.col) ||
        (a.row - 1 == b.row && a.col - 1 == b.col);
  }

  void moveHeadRight() {
    head.moveRight();
    if (!isAdjacent(head, tail)) moveKnot(head, tail);
  }

  void moveHeadLeft() {
    head.moveLeft();
    if (!isAdjacent(head, tail)) moveKnot(head, tail);
  }

  void moveHeadUp() {
    head.moveUp();
    if (!isAdjacent(head, tail)) moveKnot(head, tail);
  }

  void moveHeadDown() {
    head.moveDown();
    if (!isAdjacent(head, tail)) moveKnot(head, tail);
  }

  void moveKnot(Position first, Position next) {
    if (first.col == next.col + 2 && first.row == next.row) {
      next.moveRight();
    } else if (first.col == next.col - 2 && first.row == next.row) {
      next.moveLeft();
    } else if (first.col == next.col && first.row == next.row + 2) {
      next.moveDown();
    } else if (first.col == next.col && first.row == next.row - 2) {
      next.moveUp();
    } else if (next.col < first.col && next.row < first.row) {
      next
        ..moveDown()
        ..moveRight();
    } else if (next.col > first.col && next.row < first.row) {
      next
        ..moveDown()
        ..moveLeft();
    } else if (next.col < first.col && next.row > first.row) {
      next
        ..moveUp()
        ..moveRight();
    } else if (next.col > first.col && next.row > first.row) {
      next
        ..moveUp()
        ..moveLeft();
    }
  }

  @override
  String toString() {
    final grid = List<String>.filled(rows * cols, '.');

    for (var i = knots.length - 1; i >= 0; i--) {
      final knot = (knots[i].row * cols) + knots[i].col;

      if (i == 0) {
        grid[knot] = 'H';
      } else if (i == 1 && knots.length == 2) {
        grid[knot] = 'T';
      } else {
        grid[knot] = '$i';
      }
    }

    return grid.slices(cols).map((element) => element.join()).join('\n');
  }

  void markTailLocation() {
    setValue(true, row: tail.row, col: tail.col);
  }

  int countTailVisitedLocation() {
    final locations = grid.flattened.where((element) => element == true).length;
    return locations;
  }

  void setValue(bool value, {required int row, required int col}) =>
      grid[row][col] = value;

  void moveSingle(String instruction) {
    final step = instruction.split(' ');
    final direction = step.first;
    final iterations = int.parse(step.last);
    for (var i = 0; i < iterations; i++) {
      markTailLocation();
      switch (direction) {
        case 'U':
          moveHeadUp();
          break;
        case 'D':
          moveHeadDown();
          break;
        case 'L':
          moveHeadLeft();
          break;
        case 'R':
          moveHeadRight();
          break;
      }
      markTailLocation();
    }
  }

  void moveMultiple(List<String> instructions) {
    for (final instruction in instructions) {
      moveSingle(instruction);
    }
  }
}

const testData = <String>[
  'R 4',
  'U 4',
  'L 3',
  'D 1',
  'R 4',
  'D 1',
  'L 5',
  'R 2',
];

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day09.txt';
  final data = File(path).readAsLinesSync();

  final bridge = Bridge.filled(width: 1000, height: 1000);
  for (final row in data) {
    bridge.moveSingle(row);
  }
  print(bridge.countTailVisitedLocation());
}
// coverage:ignore-end
