class Position {
  int row;
  int col;

  Position({required this.row, required this.col});

  void moveLeft() => col--;
  void moveRight() => col++;
  void moveUp() => row--;
  void moveDown() => row++;

  @override
  String toString() => 'r: $row, c: $col';

  bool adjacentTo(Position other) {
    return (row == other.row && col == other.col) ||
        (row + 1 == other.row && col == other.col) ||
        (row - 1 == other.row && col == other.col) ||
        (row == other.row && col + 1 == other.col) ||
        (row == other.row && col - 1 == other.col) ||
        (row + 1 == other.row && col + 1 == other.col) ||
        (row + 1 == other.row && col - 1 == other.col) ||
        (row - 1 == other.row && col + 1 == other.col) ||
        (row - 1 == other.row && col - 1 == other.col);
  }
}
