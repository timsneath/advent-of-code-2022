import 'package:test/test.dart';

import '../bin/day08.dart';

const testData = <String>[
  '30373',
  '25512',
  '65332',
  '33549',
  '35390',
];

void main() {
  test('forest init', () {
    final forest = Forest.filled(width: 10, height: 2)..setRow(0, '1234567890');
    expect(forest.getValue(col: 2, row: 0), equals(3));
  });

  test('forest dimensions', () {
    final forest = Forest.filled(width: 10, height: 2);
    expect(forest.cols, equals(10));
    expect(forest.rows, equals(2));
  });

  test('load data', () {
    final forest = Forest.fromData(testData);

    expect(forest.rows, equals(5));
    expect(forest.cols, equals(5));
    expect(forest.getValue(row: 0, col: 0), equals(3));
    expect(forest.getValue(row: 0, col: 1), equals(0));
    expect(forest.getValue(row: 0, col: 2), equals(3));
    expect(forest.getValue(row: 0, col: 3), equals(7));
    expect(forest.getValue(row: 0, col: 4), equals(3));
    expect(forest.getValue(row: 1, col: 1), equals(5));
    expect(forest.getValue(row: 4, col: 4), equals(0));
    expect(forest.getValue(col: 1, row: 3), equals(3));
    expect(forest.getValue(col: 3, row: 1), equals(1));
  });

  test('treesNorth', () {
    final forest = Forest.fromData(testData);

    expect(forest.treesNorth(row: 2, col: 2), unorderedEquals([3, 5]));
    expect(forest.treesNorth(row: 3, col: 3), unorderedEquals([7, 1, 3]));
  });

  test('treesSouth', () {
    final forest = Forest.fromData(testData);

    expect(forest.treesSouth(row: 2, col: 2), unorderedEquals([5, 3]));
    expect(forest.treesSouth(row: 3, col: 3), unorderedEquals([9]));
  });

  test('treesEast', () {
    final forest = Forest.fromData(testData);

    expect(forest.treesEast(row: 2, col: 2), unorderedEquals([3, 2]));
    expect(forest.treesEast(row: 3, col: 3), unorderedEquals([9]));
  });

  test('treesWest', () {
    final forest = Forest.fromData(testData);

    expect(forest.treesWest(row: 2, col: 2), unorderedEquals([6, 5]));
    expect(forest.treesWest(row: 3, col: 3), unorderedEquals([3, 3, 5]));
  });

  test('treeVisible', () {
    final forest = Forest.fromData(testData);

    expect(forest.treeVisible(row: 0, col: 0), isTrue);
    expect(forest.treeVisible(row: 1, col: 1), isTrue);
    expect(forest.treeVisible(row: 1, col: 3), isFalse);
  });

  test('countVisibleTrees', () {
    final forest = Forest.fromData(testData);

    expect(forest.countTreesVisible(), equals(21));
  });

  test('countLowerTrees', () {
    final forest = Forest.fromData(testData);

    expect(forest.countLowerTrees([3], 5), equals(1));
    expect(forest.countLowerTrees([5, 2], 5), equals(1));
    expect(forest.countLowerTrees([1, 2], 5), equals(2));
    expect(forest.countLowerTrees([3, 5, 3], 5), equals(2));
    expect(forest.countLowerTrees([], 5), equals(0));
  });

  test('scenicScore', () {
    final forest = Forest.fromData(testData);

    expect(forest.scenicScore(row: 1, col: 2), equals(4));
    expect(forest.scenicScore(row: 3, col: 2), equals(8));
  });

  test('maxScenicScore', () {
    final forest = Forest.fromData(testData);

    expect(forest.maxScenicScore(), equals(8));
  });
}
