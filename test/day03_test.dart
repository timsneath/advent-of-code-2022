import 'package:test/test.dart';

import '../bin/day03.dart';

void main() {
  test('Split in half', () {
    expect(splitInHalf('abcdef'), equals(<String>['abc', 'def']));
    expect(splitInHalf('vJrwpWtwJgWrhcsFMMfFFhFp'),
        equals(<String>['vJrwpWtwJgWr', 'hcsFMMfFFhFp']));
  });

  test('Letter in common', () {
    expect(firstCommonCharacterIn(['abc', 'def']), isEmpty);
    expect(
        firstCommonCharacterIn(['vJrwpWtwJgWr', 'hcsFMMfFFhFp']), equals('p'));
    expect(firstCommonCharacterIn(['jqHRNqRjqzjGDLGL', 'rsFMfFZSrLrFZsSL']),
        equals('L'));
    expect(
        firstCommonCharacterIn(<String>[
          'vJrwpWtwJgWrhcsFMMfFFhFp',
          'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
          'PmmdzqPrVvPwwTWBwg'
        ]),
        equals('r'));
    expect(
        firstCommonCharacterIn(<String>[
          'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn',
          'ttgJtRGJQctTZtZT',
          'CrZsJsPPZsGzwwsLwLmpwMDw'
        ]),
        equals('Z'));
  });

  test('Character priorities', () {
    expect(calculatePriority('a'), equals(1));
    expect(calculatePriority('z'), equals(26));
    expect(calculatePriority('A'), equals(27));
    expect(calculatePriority('Z'), equals(52));
  });

  test('Sum of priorities (part 1)', () {
    expect(
        sumPriorities(<String>[
          'vJrwpWtwJgWrhcsFMMfFFhFp',
          'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
          'PmmdzqPrVvPwwTWBwg',
          'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn',
          'ttgJtRGJQctTZtZT',
          'CrZsJsPPZsGzwwsLwLmpwMDw'
        ]),
        equals(157));
  });

  test('Sum of priority triads (part 2)', () {
    expect(
        sumPriorityTriads(<String>[
          'vJrwpWtwJgWrhcsFMMfFFhFp',
          'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
          'PmmdzqPrVvPwwTWBwg',
          'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn',
          'ttgJtRGJQctTZtZT',
          'CrZsJsPPZsGzwwsLwLmpwMDw'
        ]),
        equals(70));
  });
}
