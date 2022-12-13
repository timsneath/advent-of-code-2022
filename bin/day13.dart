import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';

bool compareListList(List<dynamic> left, List<dynamic> right) {
  for (var i = 0; i < left.length; i++) {
    if (right.length <= i) return false;
    if (left[i] == right[i]) {
      continue;
    } else {
      return elfCompare(left[i], right[i]);
    }
  }
  return true; // left side ran out of items
}

bool compareListInt(List<dynamic> left, int right) =>
    compareListList(left, [right]);

bool compareIntList(int left, List<dynamic> right) =>
    compareListList([left], right);

bool elfCompare(dynamic left, dynamic right) {
  if (left is int && right is List<dynamic>) {
    return compareIntList(left, right);
  }
  if (left is List<dynamic> && right is int) {
    return compareListInt(left, right);
  }
  if (left is List<dynamic> && right is List<dynamic>) {
    return compareListList(left, right);
  }

  if (left is int && right is int) {
    return left < right;
  }

  throw StateError('Types should be either int or List<int>');
}

List<dynamic> parse(String data) => json.decode(data) as List<dynamic>;

int part1(List<String> data) {
  final rightOrderIndices = <int>[];
  final pairs = data.slices(3).toList();
  for (var i = 0; i < pairs.length; i++) {
    final left = parse(pairs[i][0]);
    final right = parse(pairs[i][1]);
    if (elfCompare(left, right)) {
      rightOrderIndices.add(i + 1);
    }
  }
  return rightOrderIndices.sum;
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day13.txt';
  final data = File(path).readAsLinesSync();

  print(part1(data));
}
// coverage:ignore-end
