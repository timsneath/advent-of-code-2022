import 'dart:io';

import 'package:collection/collection.dart';

import 'shared/position.dart';

class Bridge {
  final List<List<bool>> grid;
  final List<Position> knots;

  Bridge._(this.grid, this.knots) {
    markTailLocation();
  }

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

  void moveRope() {
    for (var knot = 0; knot < knots.length - 1; knot++) {
      if (!knots[knot].adjacentTo(knots[knot + 1])) {
        moveKnot(knots[knot], knots[knot + 1]);
      }
    }
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

  void markTailLocation() => setValue(true, row: tail.row, col: tail.col);

  int countTailVisitedLocation() =>
      grid.flattened.where((element) => element == true).length;

  void setValue(bool value, {required int row, required int col}) =>
      grid[row][col] = value;

  void moveSingle(String instruction) {
    final step = instruction.split(' ');
    final direction = step.first;
    final iterations = int.parse(step.last);
    for (var i = 0; i < iterations; i++) {
      switch (direction) {
        case 'U':
          head.moveUp();
          break;
        case 'D':
          head.moveDown();
          break;
        case 'L':
          head.moveLeft();
          break;
        case 'R':
          head.moveRight();
          break;
      }
      moveRope();
      markTailLocation();
    }
  }

  void moveMultiple(List<String> instructions) =>
      instructions.forEach(moveSingle);
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day09.txt';
  final data = File(path).readAsLinesSync();

  final part1 = Bridge.filled(width: 1000, height: 1000)..moveMultiple(data);
  print(part1.countTailVisitedLocation());

  final part2 = Bridge.filled(width: 1000, height: 1000, knotCount: 10)
    ..moveMultiple(data);
  print(part2.countTailVisitedLocation());
}
// coverage:ignore-end
