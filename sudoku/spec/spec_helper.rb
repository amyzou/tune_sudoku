require_relative '../lib/sudoku'

VALID_BOARD = [
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [4, 5, 6, 7, 8, 9, 1, 2, 3],
  [7, 8, 9, 1, 2, 3, 4, 5, 6],
  [2, 3, 1, 5, 6, 4, 8, 9, 7],
  [5, 6, 4, 8, 9, 7, 2, 3, 1],
  [8, 9, 7, 2, 3, 1, 5, 6, 4],
  [3, 1, 2, 6, 4, 5, 9, 7, 8],
  [6, 4, 5, 9, 7, 8, 3, 1, 2],
  [9, 7, 8, 3, 1, 2, 6, 4, 5],
]

UNSOLVABLE_BOARD = [
  [1, 2, 3, 4, 5, 6, 7, 8, nil],
  Array.new(9).tap { |row| row[8] = 9 },
  Array.new(9),
  Array.new(9),
  Array.new(9),
  Array.new(9),
  Array.new(9),
  Array.new(9),
  Array.new(9),
]

def unsolvable_board
  Sudoku::Board.new(Marshal.load(Marshal.dump(UNSOLVABLE_BOARD)))
end

def complete_board
  Sudoku::Board.new(Marshal.load(Marshal.dump(VALID_BOARD)))
end

def empty_board
  Sudoku::Board.new(Array.new(Sudoku::SUDOKU_SIZE).map { |row| Array.new(Sudoku::SUDOKU_SIZE) })
end
