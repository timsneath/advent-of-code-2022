import 'dart:io';
import 'package:collection/collection.dart';

const lose = 0;
const draw = 3;
const win = 6;

const rock = 1;
const paper = 2;
const scissors = 3;

// With only 9 answers, the most efficient approach is probably a lookup table

// Part 1
const scoreTable1 = <String, int>{
  // opponent plays rock
  'A X': rock + draw,
  'A Y': paper + win,
  'A Z': scissors + lose,

  // opponent plays paper
  'B X': rock + lose,
  'B Y': paper + draw,
  'B Z': scissors + win,

  // opponent plays scissors
  'C X': rock + win,
  'C Y': paper + lose,
  'C Z': scissors + draw,
};

// Part 2
const scoreTable2 = <String, int>{
  // opponent plays rock
  'A X': lose + scissors,
  'A Y': draw + rock,
  'A Z': win + paper,

  // opponent plays paper
  'B X': lose + rock,
  'B Y': draw + paper,
  'B Z': win + scissors,

  // opponent plays scissors
  'C X': lose + paper,
  'C Y': draw + scissors,
  'C Z': win + rock,
};

int calculateScore1(List<String> data) =>
    data.map((round) => scoreTable1[round]!).sum;

int calculateScore2(List<String> data) =>
    data.map((round) => scoreTable2[round]!).sum;

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day02.txt';
  final data = File(path).readAsLinesSync();

  print(calculateScore1(data));
  print(calculateScore2(data));
}
// coverage:ignore-end
