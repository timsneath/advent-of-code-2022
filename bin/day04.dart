import 'dart:io';

class Interval {
  final int start;
  final int end;

  const Interval(this.start, this.end);

  factory Interval.fromString(String range) {
    final limits = range.split('-').map(int.parse);
    return Interval(limits.first, limits.last);
  }
}

Iterable<Interval> convertRaw(String data) =>
    data.split(',').map(Interval.fromString);

bool isFirstContained(Interval first, Interval last) =>
    (first.start >= last.start) && (first.end <= last.end);

bool isIntervalContained(Iterable<Interval> ranges) =>
    isFirstContained(ranges.first, ranges.last) ||
    isFirstContained(ranges.last, ranges.first);

bool doIntervalsIntersect(Iterable<Interval> ranges) =>
    !((ranges.first.end < ranges.last.start) ||
        (ranges.first.start > ranges.last.end));

int countContainedIntervals(Iterable<String> rows) =>
    rows.map(convertRaw).map(isIntervalContained).where((e) => e).length;

int countOverlappingIntervals(Iterable<String> rows) =>
    rows.map(convertRaw).map(doIntervalsIntersect).where((e) => e).length;

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day04.txt';
  final data = File(path).readAsLinesSync();

  print(countContainedIntervals(data));
  print(countOverlappingIntervals(data));
}
// coverage:ignore-end
