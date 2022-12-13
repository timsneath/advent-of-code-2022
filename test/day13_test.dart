import 'package:test/test.dart';

import '../bin/day13.dart';

const testData = <String>[
  '[1,1,3,1,1]',
  '[1,1,5,1,1]',
  '',
  '[[1],[2,3,4]]',
  '[[1],4]',
  '',
  '[9]',
  '[[8,7,6]]',
  '',
  '[[4,4],4,4]',
  '[[4,4],4,4,4]',
  '',
  '[7,7,7,7]',
  '[7,7,7]',
  '',
  '[]',
  '[3]',
  '',
  '[[[]]]',
  '[[]]',
  '',
  '[1,[2,[3,[4,[5,6,7]]]],8,9]',
  '[1,[2,[3,[4,[5,6,0]]]],8,9]',
];

void main() {
  group('part 1', () {
    test('pair 1', () {
      final left = parse('[1, 1, 3, 1, 1]');
      final right = parse('[1, 1, 5, 1, 1]');
      expect(elfCompare(left, right), isTrue);
    });

    test('pair 2', () {
      final left = parse('[[1],[2,3,4]]');
      final right = parse('[[1],4]');
      expect(elfCompare(left, right), isTrue);
    });

    test('pair 3', () {
      final left = parse('[9]');
      final right = parse('[[8,7,6]]');
      expect(elfCompare(left, right), isFalse);
    });

    test('pair 4', () {
      final left = parse('[[4,4],4,4]');
      final right = parse('[[4,4],4,4,4]');
      expect(elfCompare(left, right), isTrue);
    });

    test('pair 5', () {
      final left = parse('[7,7,7,7]');
      final right = parse('[7,7,7]');
      expect(elfCompare(left, right), isFalse);
    });

    test('pair 6', () {
      final left = parse('[]');
      final right = parse('[3]');
      expect(elfCompare(left, right), isTrue);
    });

    test('pair 7', () {
      final left = parse('[[[]]]');
      final right = parse('[[]]');
      expect(elfCompare(left, right), isFalse);
    });

    test('pair 8', () {
      final left = parse('[1,[2,[3,[4,[5,6,7]]]],8,9]');
      final right = parse('[1,[2,[3,[4,[5,6,0]]]],8,9]');
      expect(elfCompare(left, right), isFalse);
    });

    test('more tests 1', () {
      final left = parse('[1]');
      final right = parse('[2]');
      expect(elfCompare(left, right), isTrue);
    });

    test('more tests 2', () {
      final left = parse('[1, 2]');
      final right = parse('[2]');
      expect(elfCompare(left, right), isTrue);
    });

    test('more tests 3', () {
      final left = parse('[1, 2]');
      final right = parse('[1, 2, 3, 4]');
      expect(elfCompare(left, right), isTrue);
    });

    test('more tests 4', () {
      final left = parse('[1, 2, 3, 4]');
      final right = parse('[1, 2]');
      expect(elfCompare(left, right), isFalse);
    });

    test('sample data', () {
      expect(part1(testData), equals(13));
    });
  });

  group('part 2', () {});
}
