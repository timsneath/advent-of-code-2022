import 'dart:io';

import 'package:collection/collection.dart';

String concatPath(String path1, String path2) {
  if (path1 == '/') {
    return '/$path2';
  } else {
    return '$path1/$path2';
  }
}

String cd(String path, String current) {
  if (path == '..') {
    return current.substring(0, current.lastIndexOf('/'));
  }
  if (path == '/') {
    return '/';
  }

  return concatPath(current, path);
}

MapEntry<String, int>? addFile(String row) {
  final node = row.split(' ');
  if (node.first.startsWith('dir')) return null;

  return MapEntry(node.last, int.parse(node.first));
}

/// Returns a map of the size of each directory, not including subdirectories.
Map<String, int> processFileSystem(List<String> data) {
  var pwd = '';
  final tree = <String, int>{};

  for (var row = 0; row < data.length; row++) {
    if (data[row].startsWith(r'$ cd ')) {
      pwd = cd(data[row].split(' ').last, pwd);
    }

    if (data[row].startsWith(r'$ ls')) {
      var totalFileSizes = 0;
      while (row < data.length - 1 && !data[++row].startsWith(r'$')) {
        final file = addFile(data[row]);

        if (file != null) {
          totalFileSizes += file.value;
        }
      }
      tree[pwd] = totalFileSizes;
      row--;
    }
  }

  return tree;
}

// Returns a map that contains the size of each parent directory, including
// subdirectories.
Map<String, int> sumDirectories(List<String> data) {
  final tree = processFileSystem(data);
  final totals = <String, int>{};

  for (final parent in tree.keys) {
    var total = 0;
    for (final entry in tree.entries) {
      if (entry.key.startsWith(parent)) {
        total += entry.value;
      }
    }
    totals[parent] = total;
  }

  return totals;
}

int part1(List<String> data) {
  final totals = sumDirectories(data);
  return totals.values.where((v) => v <= 100000).toList().sum;
}

int part2(List<String> data) {
  final totals = sumDirectories(data);
  const diskCapacity = 70000000;
  const neededSpace = 30000000;
  final currentUsage = totals['/']!;
  final spaceToFind = currentUsage - (diskCapacity - neededSpace);

  final sorted = totals.values.toList()..sort();

  return sorted.firstWhere((entry) => entry >= spaceToFind);
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'data/day07.txt';
  final data = File(path).readAsLinesSync();

  print(part1(data));
  print(part2(data));
}
// coverage:ignore-end
