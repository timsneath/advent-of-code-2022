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
}

class Bridge {
  final List<List<bool>> grid;
  final Position head;
  final Position tail;

  Bridge._(this.grid, this.head, this.tail);

  factory Bridge.filled({int width = 10, int height = 10}) {
    final grid = List<List<bool>>.generate(
        height, (_) => List<bool>.filled(width, false));
    final head = Position(col: width ~/ 2, row: height ~/ 2);
    final tail = Position(col: width ~/ 2, row: height ~/ 2);
    return Bridge._(grid, head, tail);
  }

  int get rows => grid.length;
  int get cols => grid[0].length;

  bool isTailAdjacent() {
    return (tail.row == head.row && tail.col == head.col) ||
        (tail.row + 1 == head.row && tail.col == head.col) ||
        (tail.row - 1 == head.row && tail.col == head.col) ||
        (tail.row == head.row && tail.col + 1 == head.col) ||
        (tail.row == head.row && tail.col - 1 == head.col) ||
        (tail.row + 1 == head.row && tail.col + 1 == head.col) ||
        (tail.row + 1 == head.row && tail.col - 1 == head.col) ||
        (tail.row - 1 == head.row && tail.col + 1 == head.col) ||
        (tail.row - 1 == head.row && tail.col - 1 == head.col);
  }

  void moveHeadRight() {
    head.moveRight();
    if (!isTailAdjacent()) moveTail();
  }

  void moveHeadLeft() {
    head.moveLeft();
    if (!isTailAdjacent()) moveTail();
  }

  void moveHeadUp() {
    head.moveUp();
    if (!isTailAdjacent()) moveTail();
  }

  void moveHeadDown() {
    head.moveDown();
    if (!isTailAdjacent()) moveTail();
  }

  void moveTail() {
    // Rule 1: move directly
    if (head.col == tail.col + 2 && head.row == tail.row) {
      tail.moveRight();
    } else if (head.col == tail.col - 2 && head.row == tail.row) {
      tail.moveLeft();
    } else if (head.col == tail.col && head.row == tail.row + 2) {
      tail.moveDown();
    } else if (head.col == tail.col && head.row == tail.row - 2) {
      tail.moveUp();
    } else if (tail.col < head.col && tail.row < head.row) {
      tail
        ..moveDown()
        ..moveRight();
    } else if (tail.col > head.col && tail.row < head.row) {
      tail
        ..moveDown()
        ..moveLeft();
    } else if (tail.col < head.col && tail.row > head.row) {
      tail
        ..moveUp()
        ..moveRight();
    } else if (tail.col > head.col && tail.row > head.row) {
      tail
        ..moveUp()
        ..moveLeft();
    }
  }

  @override
  String toString() {
    final grid = List<String>.filled(rows * cols, '.');
    final tailPos = (tail.row * cols) + tail.col;
    final headPos = (head.row * cols) + head.col;

    grid[tailPos] = 'T';
    grid[headPos] = 'H';
    final foo = grid.slices(cols).map((element) => element.join());
    final toPrint = foo.join('\n');
    return toPrint;
  }

  void markTailLocation() {
    setValue(true, row: tail.row, col: tail.col);
  }

  int countTailVisitedLocation() {
    final locations = grid.flattened.where((element) => element == true).length;
    return locations;
  }

  bool getValue({required int row, required int col}) => grid[row][col];
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
