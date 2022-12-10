import 'package:test/test.dart';

import '../bin/day10.dart';

const simpleData = <String>['noop', 'addx 3', 'addx -5'];

const testData = <String>[
  'addx 15',
  'addx -11',
  'addx 6',
  'addx -3',
  'addx 5',
  'addx -1',
  'addx -8',
  'addx 13',
  'addx 4',
  'noop',
  'addx -1',
  'addx 5',
  'addx -1',
  'addx 5',
  'addx -1',
  'addx 5',
  'addx -1',
  'addx 5',
  'addx -1',
  'addx -35',
  'addx 1',
  'addx 24',
  'addx -19',
  'addx 1',
  'addx 16',
  'addx -11',
  'noop',
  'noop',
  'addx 21',
  'addx -15',
  'noop',
  'noop',
  'addx -3',
  'addx 9',
  'addx 1',
  'addx -3',
  'addx 8',
  'addx 1',
  'addx 5',
  'noop',
  'noop',
  'noop',
  'noop',
  'noop',
  'addx -36',
  'noop',
  'addx 1',
  'addx 7',
  'noop',
  'noop',
  'noop',
  'addx 2',
  'addx 6',
  'noop',
  'noop',
  'noop',
  'noop',
  'noop',
  'addx 1',
  'noop',
  'noop',
  'addx 7',
  'addx 1',
  'noop',
  'addx -13',
  'addx 13',
  'addx 7',
  'noop',
  'addx 1',
  'addx -33',
  'noop',
  'noop',
  'noop',
  'addx 2',
  'noop',
  'noop',
  'noop',
  'addx 8',
  'noop',
  'addx -1',
  'addx 2',
  'addx 1',
  'noop',
  'addx 17',
  'addx -9',
  'addx 1',
  'addx 1',
  'addx -3',
  'addx 11',
  'noop',
  'noop',
  'addx 1',
  'noop',
  'addx 1',
  'noop',
  'noop',
  'addx -13',
  'addx -19',
  'addx 1',
  'addx 3',
  'addx 26',
  'addx -30',
  'addx 12',
  'addx -1',
  'addx 3',
  'addx 1',
  'noop',
  'noop',
  'noop',
  'addx -9',
  'addx 18',
  'addx 1',
  'addx 2',
  'noop',
  'noop',
  'addx 9',
  'noop',
  'noop',
  'noop',
  'addx -1',
  'addx 2',
  'addx -37',
  'addx 1',
  'addx 3',
  'noop',
  'addx 15',
  'addx -21',
  'addx 22',
  'addx -6',
  'addx 1',
  'noop',
  'addx 2',
  'addx 1',
  'noop',
  'addx -10',
  'noop',
  'noop',
  'addx 20',
  'addx 1',
  'addx 2',
  'addx 2',
  'addx -6',
  'addx -11',
  'noop',
  'noop',
  'noop',
];

void main() {
  group('part 1', () {
    test('cpu runs', () {
      final cpu = CPU(simpleData)..start();
      expect(cpu.x, equals(-1));
      expect(cpu.cycles, equals(5));
      expect(cpu.pc, equals(3));
    });

    test('sample data', () {
      final cpu = CPU(testData, 20)..start();
      expect(cpu.xHistory[0], equals(21));
      expect(cpu.xHistory[2], equals(19));
      expect(cpu.xHistory[4], equals(18));
      expect(cpu.xHistory[6], equals(21));
      expect(cpu.xHistory[8], equals(16));
      expect(cpu.xHistory[10], equals(18));

      expect(cpu.cpuHistory[0], equals(420));
      expect(cpu.cpuHistory[2], equals(1140));
      expect(cpu.cpuHistory[4], equals(1800));
      expect(cpu.cpuHistory[6], equals(2940));
      expect(cpu.cpuHistory[8], equals(2880));
      expect(cpu.cpuHistory[10], equals(3960));
    });
  });

  group('part 2', () {});
}
