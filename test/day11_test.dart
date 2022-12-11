import 'package:test/test.dart';

import '../bin/day11.dart';

const testData = <String>[
  'Monkey 0:',
  '  Starting items: 79, 98',
  '  Operation: new = old * 19',
  '  Test: divisible by 23',
  '    If true: throw to monkey 2',
  '    If false: throw to monkey 3',
  '',
  'Monkey 1:',
  '  Starting items: 54, 65, 75, 74',
  '  Operation: new = old + 6',
  '  Test: divisible by 19',
  '    If true: throw to monkey 2',
  '    If false: throw to monkey 0',
  '',
  'Monkey 2:',
  '  Starting items: 79, 60, 97',
  '  Operation: new = old * old',
  '  Test: divisible by 13',
  '    If true: throw to monkey 1',
  '    If false: throw to monkey 3',
  '',
  'Monkey 3:',
  '  Starting items: 74',
  '  Operation: new = old + 3',
  '  Test: divisible by 17',
  '    If true: throw to monkey 0',
  '    If false: throw to monkey 1',
];

void main() {
  group('part 1', () {
    test('load operation', () {
      const str = '  Operation: new = old + 3';
      final operation = Operation.fromString(str);
      expect(operation.operand, equals(3));
      expect(operation.operator, equals(Operator.plus));
    });

    test('load data', () {
      final monkeys = Monkeys.fromData(testData);
      final first = monkeys.first;
      expect(first.id, isZero);
      expect(first.worryLevels, equals([79, 98]));
      expect(first.operation.operator, equals(Operator.multiply));
      expect(first.operation.operand, equals(19));
      expect(first.testModulo, equals(23));
      expect(first.throwIfTrue, equals(2));
      expect(first.throwIfFalse, equals(3));

      final last = monkeys.last;
      expect(last.id, equals(3));
      expect(last.worryLevels.length, equals(1));
      expect(last.operation.operator, equals(Operator.plus));
    });

    test('calculate', () {
      expect(const Operation(Operator.plus, 2).calculate(6), equals(8));
      expect(const Operation(Operator.multiply, 2).calculate(6), equals(12));
      expect(const Operation(Operator.square, 0).calculate(6), equals(36));
    });

    test('round 1', () {
      final monkeys = Monkeys.fromData(testData)..processRound();

      expect(monkeys.toString(), startsWith('Monkey 0: [20, 23, 27, 26]'));
    });

    test('round 2', () {
      final monkeys = Monkeys.fromData(testData)
        ..processRound()
        ..processRound();

      expect(
          monkeys.toString(), startsWith('Monkey 0: [695, 10, 71, 135, 350]'));
    });

    test('round 20', () {
      final monkeys = Monkeys.fromData(testData);
      for (var i = 0; i < 20; i++) {
        monkeys.processRound();
      }

      expect(monkeys.toString(), startsWith('Monkey 0: [10, 12, 14, 26, 34]'));
    });

    test('items inspected', () {
      final monkeys = Monkeys.fromData(testData);
      for (var i = 0; i < 20; i++) {
        monkeys.processRound();
      }

      expect(monkeys.monkeys.map((m) => m.itemsInspected),
          equals([101, 95, 7, 105]));
    });

    test('total items after 20 rounds', () {
      final monkeys = Monkeys.fromData(testData)..processRounds(20);
      expect(monkeys.topTwoMonkeysProduct(), equals(10605));
    });
  });

  group('part 2', () {
    test('total items after n rounds', () {
      final monkeys1 = Monkeys.fromData(testData, divideByThreeRule: false)
        ..processRounds(1);
      expect(monkeys1.itemsInspected, equals([2, 4, 3, 6]));

      final monkeys20 = Monkeys.fromData(testData, divideByThreeRule: false)
        ..processRounds(20);
      expect(monkeys20.itemsInspected, equals([99, 97, 8, 103]));

      final monkeys1000 = Monkeys.fromData(testData, divideByThreeRule: false)
        ..processRounds(1000);
      expect(monkeys1000.itemsInspected, equals([5204, 4792, 199, 5192]));
    });

    test('total items after 10000 rounds', () {
      final monkeys = Monkeys.fromData(testData, divideByThreeRule: false)
        ..processRounds(10000);
      expect(monkeys.topTwoMonkeysProduct(), equals(2713310158));
    });
  });
}
