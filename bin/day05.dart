import 'dart:collection';
import 'dart:io';

class Step {
  final int count;
  final int from;
  final int to;

  const Step(this.count, this.from, this.to);

  /// Takes an instruction of the form "move [count] from [from] to [to]"
  factory Step.fromString(String step) {
    final instructionList = step.split(' ');
    final count = int.parse(instructionList[1]);
    final from = int.parse(instructionList[3]);
    final to = int.parse(instructionList[5]);

    return Step(count, from, to);
  }
}

Iterable<Step> parseSteps(List<String> data) {
  final stepStartRow =
      data.indexWhere((element) => element.startsWith('move '));

  return data.sublist(stepStartRow).map(Step.fromString);
}

List<Queue<String>> loadCrateData(List<String> data) {
  final stacksAxis = data.indexWhere((element) => element.startsWith(' 1 '));
  final stacksCount = data[stacksAxis].split('   ');
  final stacks = List<Queue<String>>.generate(
      stacksCount.length, (index) => Queue<String>());

  for (var stackHeight = stacksAxis - 1; stackHeight >= 0; stackHeight--) {
    final row = data[stackHeight];
    for (var stack = 0; stack < stacksCount.length; stack++) {
      final crate = row[(stack * 4) + 1];
      if (crate != ' ') stacks[stack].addFirst(crate);
    }
  }

  return stacks;
}

List<Queue<String>> moveCrates9000(
    List<Queue<String>> stacks, Iterable<Step> steps) {
  for (final step in steps) {
    for (var i = 0; i < step.count; i++) {
      final crate = stacks[step.from - 1].removeFirst();
      stacks[step.to - 1].addFirst(crate);
    }
  }

  return stacks;
}

List<Queue<String>> moveCrates9001(
    List<Queue<String>> stacks, Iterable<Step> steps) {
  for (final step in steps) {
    final cratesMoving =
        stacks[step.from - 1].take(step.count).toList().reversed;

    for (final crate in cratesMoving) {
      stacks[step.from - 1].removeFirst();
      stacks[step.to - 1].addFirst(crate);
    }
  }

  return stacks;
}

String topCrates(List<Queue<String>> stacks) {
  return stacks.map((e) => e.first).join();
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day05.txt';
  final data = File(path).readAsLinesSync();

  final steps = parseSteps(data);

  final stacks9000 = loadCrateData(data);
  final movedCrates9000 = moveCrates9000(stacks9000, steps);
  print(topCrates(movedCrates9000));

  final stacks9001 = loadCrateData(data);
  final movedCrates9001 = moveCrates9001(stacks9001, steps);
  print(topCrates(movedCrates9001));
}
// coverage:ignore-end
