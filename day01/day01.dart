import 'dart:io';

import 'package:collection/collection.dart';

List<int> countElfCalories(List<String> rawData) {
  final elfCalories = <int>[];
  var calories = 0;

  for (final calorieItem in rawData) {
    if (calorieItem.isNotEmpty) {
      calories += int.parse(calorieItem);
    } else {
      elfCalories.add(calories);
      calories = 0;
    }
  }
  return elfCalories;
}

int mostCalorificElf(List<String> rawData) => countElfCalories(rawData).max;

int topThreeCalorificElves(List<String> rawData) {
  final elvesSortedByCalories = countElfCalories(rawData)..sort();
  return elvesSortedByCalories.reversed.take(3).sum;
}

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day01/day01.txt';
  final rawData = File(path).readAsLinesSync();

  print(mostCalorificElf(rawData));
  print(topThreeCalorificElves(rawData));
}
