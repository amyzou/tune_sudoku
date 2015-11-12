module Sudoku

  class Board

    POSSIBLE_VALUES = (1..9).to_a.freeze

    SUDOKU_SIZE = POSSIBLE_VALUES.length.freeze

    attr_reader :matrix, :values

    def initialize(matrix)
      @matrix = matrix
      @values = matrix.flatten
    end

    class InvalidBoardError < TypeError; end

    # A board is valid if it is the right size (SUDOKU_SIZE rows and columns),
    # has only POSSIBLE_VALUES, and has no duplicates in each row, col, or square.
    def valid?
      return false if matrix.length != SUDOKU_SIZE && !matrix.map { |row| row.length == SUDOKU_SIZE }.reduce(:&)
      return false unless (values.compact.uniq - POSSIBLE_VALUES).empty?
      return !duplicate_values?
    end

    def row(i)
      matrix[i]
    end

    def col(i)
      matrix.map { |row| row[i] }
    end

    SQUARE_OFFSET = [0, 3, 6, 27, 30, 33, 54, 57, 60].freeze
    SQUARE_INDEX  = [0, 1, 2, 9, 10, 11, 18, 19, 20].freeze
    def square(i)
      offset = SQUARE_OFFSET[i]
      SQUARE_INDEX.map { |index| values[offset + index] }
    end

    def dup
      self.class.new(Marshal.load(Marshal.dump(matrix)))
    end

    def set(row, col, value)
      matrix[row][col] = value
      values[row * SUDOKU_SIZE + col] = value
    end

    def to_s
      return matrix.map do |row|
        row = row.map { |e| e || '-' }
        row.join(',')
      end.join("\n")
    end

    private

    def duplicate_values?
      SUDOKU_SIZE.times do |i|
        return true unless row(i).uniq.compact == row(i).compact
        return true unless col(i).uniq.compact == col(i).compact
        return true unless square(i).uniq.compact == square(i).compact
        return false
      end
    end

  end

end
