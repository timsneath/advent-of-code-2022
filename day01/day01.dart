import 'dart:io';

int doStuff(List<String> rawData) {
  return rawData.length;
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day01/day01.txt';
  final rawData = File(path).readAsLinesSync();

  doStuff(rawData);
}
// coverage:ignore-end
