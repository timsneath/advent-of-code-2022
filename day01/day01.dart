import 'dart:io';

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day01/day01.txt';
  final rawData = File(path).readAsLinesSync();

  // Do stuff
}
// coverage:ignore-end
