import 'dart:io';

import 'package:characters/characters.dart';
import 'package:collection/collection.dart';

List<String> splitInHalf(String string) => [
      string.substring(0, string.length ~/ 2),
      string.substring(string.length ~/ 2)
    ];

String firstCommonCharacterIn(List<String> items) {
  for (final char in items.first.characters) {
    if (items.every((string) => string.contains(char))) return char;
  }
  return '';
}

int calculatePriority(String character) {
  // Priorities are values from 1 to 52, for the set [a..z, A..Z]
  if (character.toLowerCase() == character) {
    return character.codeUnits.first - 'a'.codeUnits.first + 1;
  }

  if (character.toUpperCase() == character) {
    return character.codeUnits.first - 'A'.codeUnits.first + 27;
  }

  return 0;
}

int sumPriorities(List<String> rows) => rows
    .map(splitInHalf)
    .map(firstCommonCharacterIn)
    .map(calculatePriority)
    .sum;

int sumPriorityTriads(List<String> rows) => rows
    .splitBeforeIndexed((index, _) => index % 3 == 0)
    .map(firstCommonCharacterIn)
    .map(calculatePriority)
    .sum;

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day03.txt';
  final data = File(path).readAsLinesSync();

  print(sumPriorities(data));
  print(sumPriorityTriads(data));
}
// coverage:ignore-end