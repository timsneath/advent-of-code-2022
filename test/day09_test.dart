import 'package:test/test.dart';

import '../bin/day09.dart';

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

void main() {
  group('part 1', () {
    test('no moves', () {
      final bridge = Bridge.filled(
          height: 5, width: 6, startPosition: Position(row: 4, col: 0));
      expect(
          bridge.toString(), equals('......\n......\n......\n......\nH.....'));
    });

    test('first move', () {
      final bridge = Bridge.filled(
          height: 5, width: 6, startPosition: Position(row: 4, col: 0))
        ..moveSingle('R 1');
      expect(
          bridge.toString(), equals('......\n......\n......\n......\nTH....'));
    });

    test('correct moves', () {
      final bridge = Bridge.filled(
          height: 5, width: 6, startPosition: Position(row: 4, col: 0))
        ..moveMultiple(testData);
      expect(
          bridge.toString(), equals('......\n......\n.TH...\n......\n......'));
    });

    test('correct locations visited', () {
      final bridge = Bridge.filled(
          height: 5, width: 6, startPosition: Position(row: 4, col: 0))
        ..moveMultiple(testData);
      expect(bridge.countTailVisitedLocation(), equals(13));
    });
  });

  group('part 2', () {
    test('r4 with 10 knots', () {
      final bridge = Bridge.filled(
          height: 5,
          width: 6,
          knotCount: 10,
          startPosition: Position(row: 4, col: 0))
        ..moveSingle('R 4');
      expect(
          bridge.toString(), equals('......\n......\n......\n......\n4321H.'));
    });

    test('r4u4 with 10 knots', () {
      final bridge = Bridge.filled(
          height: 5,
          width: 6,
          knotCount: 10,
          startPosition: Position(row: 4, col: 0))
        ..moveSingle('R 4')
        ..moveSingle('U 4');
      expect(
          bridge.toString(), equals('....H.\n....1.\n..432.\n.5....\n6.....'));
    });

    test('all moves', () {
      final bridge = Bridge.filled(
          height: 5,
          width: 6,
          knotCount: 10,
          startPosition: Position(row: 4, col: 0))
        ..moveMultiple(testData);
      expect(
          bridge.toString(), equals('......\n......\n.1H3..\n.5....\n6.....'));
    });
  });
}
