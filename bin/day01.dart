import 'dart:io';

import 'package:collection/collection.dart';

List<int> countElfCalories(List<String> data) {
  final elfCalories = <int>[];
  var currentCalories = 0;

  for (final row in data) {
    if (row.isNotEmpty) {
      currentCalories += int.parse(row);
    } else {
      elfCalories.add(currentCalories);
      currentCalories = 0;
    }
  }
  return elfCalories;
}

int mostCalorificElf(List<String> data) => countElfCalories(data).max;

int topThreeCalorificElves(List<String> data) {
  final elvesSortedByCalories = countElfCalories(data)..sort();
  return elvesSortedByCalories.reversed.take(3).sum;
}

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day01.txt';
  final data = File(path).readAsLinesSync();

  print(mostCalorificElf(data));
  print(topThreeCalorificElves(data));
}
