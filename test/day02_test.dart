import 'package:test/test.dart';

import '../bin/day02.dart';

void main() {
  test('Score game 1', () {
    expect(calculateScore1(['A Y', 'B X', 'C Z']), equals(15));
  });

  test('Score game 2', () {
    expect(calculateScore2(['A Y', 'B X', 'C Z']), equals(12));
  });
}
