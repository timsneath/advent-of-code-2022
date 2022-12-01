import 'package:test/test.dart';

import '../day01/day01.dart';

void main() {
  test('Elf calorie count', () {
    expect(
        mostCalorificElf([
          '1000', '2000', '3000', '', // elf 1
          '4000', '', // elf 2
          '5000', '6000', '', // elf 3
          '7000', '8000', '9000', '', // elf 4
          '10000', '' // elf 5
        ]),
        equals(24000));
  });

  test('Top 3 elves calorie count', () {
    expect(
        topThreeCalorificElves([
          '1000', '2000', '3000', '', // elf 1
          '4000', '', // elf 2
          '5000', '6000', '', // elf 3
          '7000', '8000', '9000', '', // elf 4
          '10000', '' // elf 5
        ]),
        equals(45000));
  });
}
