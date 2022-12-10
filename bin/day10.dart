import 'dart:io';

class CPU {
  int x = 1;
  int cycles = 1;
  int elapsedCycles = 0;
  int pc = 0;

  List<int> cpuHistory = [];
  List<int> xHistory = [];

  final List<String> instructions;
  final int cyclesPerMeasurement;

  CPU(this.instructions, [this.cyclesPerMeasurement = 100000000000]);

  void noop() {
    cycles++;
    endCycle();
  }

  void addx(int val) {
    cycles++;
    endCycle();

    x += val;
    cycles++;
    endCycle();
  }

  void endCycle() {
    if (cycles < cyclesPerMeasurement) {
      return;
    } else {
      elapsedCycles += cyclesPerMeasurement;
      cpuHistory.add(x * elapsedCycles);
      xHistory.add(x);
      cycles = 0;
    }
  }

  void executeInstruction(String instruction) {
    if (instruction == 'noop') {
      print('[${cycles + elapsedCycles}] x=$x $instruction NOOP');
      noop();
    } else if (instruction.startsWith('addx')) {
      final operand = int.parse(instruction.split(' ').last);
      print('[${cycles + elapsedCycles}] x=$x $instruction ADDX $operand');
      addx(operand);
    } else {
      throw 'Unidentified instruction';
    }
    pc++;
  }

  void start() {
    for (final inst in instructions) {
      executeInstruction(inst);
    }
  }
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day10.txt';
  final data = File(path).readAsLinesSync();

  final cpu = CPU(data, 20)..start();

  // find 20th, 60th, 100th, 140th, 180th, and 220th
  final values = cpu.cpuHistory[0] +
      cpu.cpuHistory[2] +
      cpu.cpuHistory[4] +
      cpu.cpuHistory[6] +
      cpu.cpuHistory[8] +
      cpu.cpuHistory[10];
  print(values);
}
// coverage:ignore-end
