import 'package:test/test.dart';

import '../bin/day06.dart';

void main() {
  test('Find end of packet marker', () {
    expect(findMarkerEndIndex('mjqjpqmgbljsphdztnvjfqwrcgsmlb', 4), equals(7));
    expect(findMarkerEndIndex('bvwbjplbgvbhsrlpgdmjqwftvncz', 4), equals(5));
    expect(findMarkerEndIndex('nppdvjthqldpwncqszvftbrmjlhg', 4), equals(6));
    expect(
        findMarkerEndIndex('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', 4), equals(10));
    expect(
        findMarkerEndIndex('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw', 4), equals(11));
  });

  test('Find end of message marker', () {
    expect(
        findMarkerEndIndex('mjqjpqmgbljsphdztnvjfqwrcgsmlb', 14), equals(19));
    expect(findMarkerEndIndex('bvwbjplbgvbhsrlpgdmjqwftvncz', 14), equals(23));
    expect(findMarkerEndIndex('nppdvjthqldpwncqszvftbrmjlhg', 14), equals(23));
    expect(findMarkerEndIndex('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', 14),
        equals(29));
    expect(
        findMarkerEndIndex('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw', 14), equals(26));
  });

  test('Test some bad input', () {
    expect(findMarkerEndIndex('', 1), equals(-1));
    expect(findMarkerEndIndex('abcabcabc', 4), equals(-1));
    expect(findMarkerEndIndex('ab', 700), equals(-1));
  });
}
