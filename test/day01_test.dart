import 'package:test/test.dart';

import '../day01/day01.dart';

void main() {
  group('Part 1', () {
    test('test 1', () {
      expect(doStuff([]), isZero);
    });
  });

  group('Part 2', () {
    test('test 2', () {
      expect(doStuff(['a', 'b', 'c']), equals(3));
    });
  });
}
