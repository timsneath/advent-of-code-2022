import 'dart:io';

import 'package:collection/collection.dart';

class Forest {
  final List<List<int>> grid;

  const Forest._(this.grid);

  factory Forest.filled({int width = 5, int height = 5}) {
    final grid =
        List<List<int>>.generate(height, (_) => List<int>.filled(width, 0));
    return Forest._(grid);
  }

  factory Forest.fromData(List<String> data) {
    final forest = Forest.filled(width: data[0].length, height: data.length);
    for (var row = 0; row < data.length; row++) {
      forest.setRow(row, data[row]);
    }
    return forest;
  }

  int get rows => grid.length;
  int get cols => grid[0].length;

  void setRow(int rowIndex, String data) {
    final rowValues = data.split('').map(int.parse);
    grid[rowIndex].setAll(0, rowValues);
  }

  int getValue({required int row, required int col}) => grid[row][col];

  Iterable<int> treesNorth({required int row, required int col}) => [
        for (var rowIdx = row - 1; rowIdx >= 0; rowIdx--)
          getValue(row: rowIdx, col: col)
      ];
  Iterable<int> treesSouth({required int row, required int col}) => [
        for (var rowIdx = row + 1; rowIdx < rows; rowIdx++)
          getValue(row: rowIdx, col: col)
      ];
  Iterable<int> treesEast({required int row, required int col}) => [
        for (var colIdx = col + 1; colIdx < cols; colIdx++)
          getValue(row: row, col: colIdx)
      ];
  Iterable<int> treesWest({required int row, required int col}) => [
        for (var colIdx = col - 1; colIdx >= 0; colIdx--)
          getValue(row: row, col: colIdx)
      ];

  bool treeVisible({required int row, required int col}) {
    final height = getValue(row: row, col: col);
    return row == 0 ||
        row == rows - 1 ||
        col == 0 ||
        col == cols - 1 ||
        treesNorth(row: row, col: col).every((tree) => tree < height) ||
        treesSouth(row: row, col: col).every((tree) => tree < height) ||
        treesEast(row: row, col: col).every((tree) => tree < height) ||
        treesWest(row: row, col: col).every((tree) => tree < height);
  }

  int countTreesVisible() {
    var visibleTrees = 0;
    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        if (treeVisible(row: row, col: col)) visibleTrees++;
      }
    }
    return visibleTrees;
  }

  int countLowerTrees(Iterable<int> trees, int treeHeight) {
    var visibleTrees = 0;
    for (final tree in trees) {
      visibleTrees++;
      if (tree >= treeHeight) break;
    }
    return visibleTrees;
  }

  int scenicScore({required int row, required int col}) {
    final treeHeight = getValue(row: row, col: col);
    return countLowerTrees(treesNorth(row: row, col: col), treeHeight) *
        countLowerTrees(treesSouth(row: row, col: col), treeHeight) *
        countLowerTrees(treesEast(row: row, col: col), treeHeight) *
        countLowerTrees(treesWest(row: row, col: col), treeHeight);
  }

  int maxScenicScore() => <int>[
        for (var row = 0; row < rows; row++)
          for (var col = 0; col < cols; col++) scenicScore(row: row, col: col)
      ].max;
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day08.txt';
  final data = File(path).readAsLinesSync();

  final forest = Forest.fromData(data);
  print(forest.countTreesVisible());
  print(forest.maxScenicScore());
}
// coverage:ignore-end
