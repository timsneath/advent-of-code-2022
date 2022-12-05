import 'package:test/test.dart';

import '../bin/day05.dart';

const testData = <String>[
  '    [D]    ',
  '[N] [C]    ',
  '[Z] [M] [P]',
  ' 1   2   3 ',
  '',
  'move 1 from 2 to 1',
  'move 3 from 1 to 3',
  'move 2 from 2 to 1',
  'move 1 from 1 to 2',
];

void main() {
  test('loadCrateData', () {
    final stacks = loadCrateData(testData);
    expect(stacks.length, equals(3));
    expect(stacks.map((s) => s.length), equals([2, 3, 1]));
  });

  test('topCrate', () {
    final stacks = loadCrateData(testData);
    expect(topCrates(stacks), equals('NDP'));
  });

  test('moveCrates9000', () {
    final stacks = loadCrateData(testData);
    final steps = parseSteps(testData);
    final newStacks = moveCrates9000(stacks, steps);
    expect(newStacks.length, equals(3));
    expect(newStacks.map((s) => s.length), equals([1, 1, 4]));
    expect(newStacks.last, equals(['Z', 'N', 'D', 'P']));
    expect(topCrates(newStacks), equals('CMZ'));
  });

  test('moveCrates9001', () {
    final stacks = loadCrateData(testData);
    final steps = parseSteps(testData);
    final newStacks = moveCrates9001(stacks, steps);
    expect(newStacks.length, equals(3));
    expect(newStacks.map((s) => s.length), equals([1, 1, 4]));
    expect(newStacks.last, equals(['D', 'N', 'Z', 'P']));
    expect(topCrates(newStacks), equals('MCD'));
  });
}
