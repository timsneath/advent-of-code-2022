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
  test('part 1', () {
    final bridge = Bridge.filled()..moveMultiple(testData);
    expect(bridge.countTailVisitedLocation(), equals(13));
  });
}
