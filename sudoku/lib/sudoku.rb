class SudokuBoard

  POSSIBLE_VALUES = (1..9).to_a.freeze

  SUDOKU_SIZE = POSSIBLE_VALUES.length.freeze

  attr_reader :values

  def initialize(matrix)
    @values = matrix
  end

  def solve
    raise "not a valid board" if !valid?
  end

  private

  # A board is valid if it is the right size (SUDOKU_SIZE rows and columns),
  # has only POSSIBLE_VALUES, and has no duplicates in each row, col, or square.
  def valid?
    return false if values.length != SUDOKU_SIZE && !values.map { |row| row.length == SUDOKU_SIZE }.reduce(:&)
    return false unless (values.flatten.compact.uniq - POSSIBLE_VALUES).empty?
    return !duplicate_values?
  end

  def to_string
    values.each { |row| puts row.join(',') }
  end

  def duplicate_values?
    SUDOKU_SIZE.times { |i| return true unless row(i).uniq? }
    SUDOKU_SIZE.times { |i| return true unless col(i).uniq? }
    SUDOKU_SIZE.times { |i| return true unless square(i).uniq? }
  end

  def row(i)
    values[i]
  end

  def col(i)
    values.map { |row| row[i] }
  end

  SQUARE_OFFSET = [0, 3, 6, 27, 30, 33, 54, 57, 60].freeze
  SQUARE_INDEX  = [0, 1, 2, 9, 10, 11, 18, 19, 20].freeze
  def square(i)
    flattened = values.flatten
    offset = SQUARE_OFFSET[i]
    SQUARE_INDEX.map { |index| flattened[offset + index] }
  end

end