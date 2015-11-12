module Sudoku

  class Solver

    # Try to solve a space if it has the least number of valid
    # solutions. Then, solve the new board created.
    # If there are no empty spaces, and the board is valid, return board.
    # If there are no possible solutions to an empty square, raise
    # NoSolutionError.
    def solve(board)
      raise InvalidBoardError.new unless board.valid?
      unsolved_spaces = empty_spaces(board)
      return board if unsolved_spaces.empty?
      row, col, possible_solutions = easiest_solution_attempt(board, unsolved_spaces)

      raise NoSolutionError.new if possible_solutions.empty?
      possible_solutions.each do |possible_solution|
        new_board = board.dup.tap { |board| board.set(row, col, possible_solution) }
        return solve(new_board)
      end
    end

    class NoSolutionError < StandardError; end

    private

    # Gets an array of positions of nils in the matrix.
    def empty_spaces(board)
      board.values.map.with_index do |value, i|
        if value.nil?
          row = i / 9
          col = i % 9
          [row, col]
        end
      end.compact
    end

    def possible_values(board, row, col)
      square_i = 3 * (row / 3) + ((col / 3) % 3)
      Sudoku::POSSIBLE_VALUES -
        [board.row(row), board.col(col), board.square(square_i)].flatten.uniq
    end

    # Go through all of the nil values and get the list of possible values.
    # Sort by num of possible values, and return the one with the least.
    def easiest_solution_attempt(board, unsolved_spaces)
      unsolved_spaces
        .map { |row, col| [row, col, possible_values(board, row, col)] }
        .sort_by { |value| value[2].length }
        .first
    end

  end

end
