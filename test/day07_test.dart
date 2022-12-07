import 'package:test/test.dart';

import '../bin/day07.dart';

const testData = <String>[
  r'$ cd /',
  r'$ ls',
  r'dir a',
  r'14848514 b.txt',
  r'8504156 c.dat',
  r'dir d',
  r'$ cd a',
  r'$ ls',
  r'dir e',
  r'29116 f',
  r'2557 g',
  r'62596 h.lst',
  r'$ cd e',
  r'$ ls',
  r'584 i',
  r'$ cd ..',
  r'$ cd ..',
  r'$ cd d',
  r'$ ls',
  r'4060174 j',
  r'8033020 d.log',
  r'5626152 d.ext',
  r'7214296 k'
];

void main() {
  test('cd', () {
    expect(cd('/', '/'), equals('/'));
    expect(cd('a', '/'), equals('/a'));
    expect(cd('b', '/a'), equals('/a/b'));
    expect(cd('..', '/a/b'), equals('/a'));
    expect(cd('/', '/a/b'), equals('/'));
  });

  test('addFile', () {
    expect(addFile('dir jssbn'), equals(null));
    expect(addFile('14848514 b.txt')?.key, equals('b.txt'));
    expect(addFile('14848514 b.txt')?.value, equals(14848514));
    expect(addFile('4060174 j')?.key, equals('j'));
    expect(addFile('4060174 j')?.value, equals(4060174));
  });

  test('processFileSystem', () {
    final tree = processFileSystem(testData);

    expect(tree.keys.length, equals(4));
    expect(tree.keys.first, equals('/'));
    expect(tree.keys.last, equals('/d'));
  });

  test('sumDirectories', () {
    final sumTree = sumDirectories(testData);
    expect(sumTree['/'], equals(48381165));
  });

  test('largeDirectories', () {
    expect(part1(testData), equals(95437));
  });

  test('directory to remove', () {
    expect(part2(testData), equals(24933642));
  });
}
