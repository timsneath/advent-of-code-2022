import 'dart:collection';
import 'dart:io';

import 'package:collection/collection.dart';

enum Operator { plus, multiply, square }

class Operation {
  final Operator operator;
  final int operand;

  const Operation(this.operator, this.operand);

  factory Operation.fromString(String function) {
    final words = function.split(' ').reversed.toList();
    if (words.first == 'old' && words[1] == '*') {
      return const Operation(Operator.square, 0);
    } else {
      return Operation(words[1] == '*' ? Operator.multiply : Operator.plus,
          int.parse(words.first));
    }
  }
  int calculate(int old) {
    if (operator == Operator.square) return old * old;
    if (operator == Operator.multiply) return old * operand;
    return old + operand;
  }
}

class ThrownItem {
  final int thrownToMonkey;
  final int worryLevel;

  const ThrownItem(this.thrownToMonkey, this.worryLevel);
}

class Monkey {
  final int id;
  final Queue<int> worryLevels;
  final Operation operation;
  final int testModulo;
  final int throwIfTrue;
  final int throwIfFalse;
  bool divideByThreeRule;
  int itemsInspected = 0;

  Monkey(this.id, this.worryLevels, this.operation, this.testModulo,
      this.throwIfTrue, this.throwIfFalse, this.divideByThreeRule);

  factory Monkey.fromString(List<String> monkey,
      {bool divideByThreeRule = true}) {
    final id = int.parse(monkey[0].substring(7, 8));
    final items =
        Queue<int>.from(monkey[1].split(': ').last.split(', ').map(int.parse));
    final operation = Operation.fromString(monkey[2]);
    final testModulo = int.parse(monkey[3].split(' ').last);
    final throwIfTrue = int.parse(monkey[4].split(' ').last);
    final throwIfFalse = int.parse(monkey[5].split(' ').last);
    return Monkey(id, items, operation, testModulo, throwIfTrue, throwIfFalse,
        divideByThreeRule);
  }

  ThrownItem processItem(int oldWorryLevel) {
    itemsInspected++;
    final newWorryLevel = operation.calculate(oldWorryLevel);
    final boredWorryLevel =
        divideByThreeRule ? newWorryLevel ~/ 3 : newWorryLevel;
    if (boredWorryLevel % testModulo == 0) {
      return ThrownItem(throwIfTrue, boredWorryLevel);
    } else {
      return ThrownItem(throwIfFalse, boredWorryLevel);
    }
  }

  Iterable<ThrownItem> processItems() {
    final processedItems = <ThrownItem>[];

    while (worryLevels.isNotEmpty) {
      final worryLevel = worryLevels.removeFirst();
      processedItems.add(processItem(worryLevel));
    }

    return processedItems;
  }
}

class Monkeys {
  late final List<Monkey> monkeys;

  int get length => monkeys.length;
  Monkey get first => monkeys.first;
  Monkey get last => monkeys.last;

  Monkeys.fromData(List<String> data, {bool divideByThreeRule = true}) {
    monkeys = data
        .slices(7)
        .map((m) => Monkey.fromString(m, divideByThreeRule: divideByThreeRule))
        .toList();
  }

  void processRound() {
    for (final monkey in monkeys) {
      final itemsThrown = monkey.processItems();
      for (final item in itemsThrown) {
        monkeys[item.thrownToMonkey].worryLevels.add(item.worryLevel);
      }
    }
  }

  void processRounds(int rounds) {
    for (var i = 0; i < rounds; i++) {
      processRound();
    }
  }

  List<int> get itemsInspected => monkeys.map((m) => m.itemsInspected).toList();

  int topTwoMonkeysProduct() {
    final inspected = (itemsInspected..sort()).reversed.toList();
    return inspected[0] * inspected[1];
  }

  @override
  String toString() => monkeys
      .map((m) => 'Monkey ${m.id}: ${m.worryLevels.toList().toString()}')
      .join('\n');
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day11.txt';
  final data = File(path).readAsLinesSync();
  final part1 = Monkeys.fromData(data)..processRounds(20);
  print(part1.topTwoMonkeysProduct());

  final part2 = Monkeys.fromData(data, divideByThreeRule: false)
    ..processRounds(10000);
  print(part2.topTwoMonkeysProduct());
}
// coverage:ignore-end
