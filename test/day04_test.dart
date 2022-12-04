import 'package:test/test.dart';

import '../bin/day04.dart';

void main() {
  test('countContainedRanges', () {
    expect(
        countContainedIntervals(
            ['2-4,6-8', '2-3,4-5', '5-7,7-9', '2-8,3-7', '6-6,4-6', '2-6,4-8']),
        equals(2));
  });

  test('countOverlappingRanges', () {
    expect(
        countOverlappingIntervals(
            ['2-4,6-8', '2-3,4-5', '5-7,7-9', '2-8,3-7', '6-6,4-6', '2-6,4-8']),
        equals(4));
  });
}
