import 'dart:io';

import 'package:collection/collection.dart';

class CPU {
  int x = 1;
  int cycleInFrame = 1;
  int elapsedCycles = 0;
  int pc = 0;

  List<int> cpuHistory = [];
  List<int> xHistory = [];

  List<String> crtBuffer = [];

  final List<String> instructions;
  final int cyclesPerLogpoint;
  final int cyclesPerFrame;

  CPU(this.instructions,
      {this.cyclesPerLogpoint = 100000000000, this.cyclesPerFrame = 40});

  void noop() {
    crtPaint();
    cycleInFrame++;
    endCycle();
  }

  void addx(int val) {
    crtPaint();
    cycleInFrame++;
    endCycle();

    crtPaint();
    x += val;
    cycleInFrame++;
    endCycle();
  }

  void crtPaint() {
    final pos = (cycleInFrame - 1 + elapsedCycles) % 40;
    if (x == pos || x == pos - 1 || x == pos + 1) {
      crtBuffer.add('#');
    } else {
      crtBuffer.add('.');
    }
  }

  void endCycle() {
    if (cycleInFrame < cyclesPerLogpoint) {
      return;
    } else {
      elapsedCycles += cyclesPerLogpoint;
      cpuHistory.add(x * elapsedCycles);
      xHistory.add(x);
      cycleInFrame = 0;
    }
  }

  void executeInstruction(String instruction) {
    if (instruction == 'noop') {
      noop();
    } else if (instruction.startsWith('addx')) {
      final operand = int.parse(instruction.split(' ').last);
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

  String get display => crtBuffer
      .slices(cyclesPerFrame)
      .map((element) => element.join())
      .join('\n');
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day10.txt';
  final data = File(path).readAsLinesSync();

  final cpu = CPU(data, cyclesPerLogpoint: 20)..start();

  // find 20th, 60th, 100th, 140th, 180th, and 220th
  final values = cpu.cpuHistory[0] +
      cpu.cpuHistory[2] +
      cpu.cpuHistory[4] +
      cpu.cpuHistory[6] +
      cpu.cpuHistory[8] +
      cpu.cpuHistory[10];
  print(values);

  // Print the display
  print(cpu.display);
}
// coverage:ignore-end
