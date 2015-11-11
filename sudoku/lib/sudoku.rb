require_relative 'board'

module Sudoku

  POSSIBLE_VALUES = (1..9).to_a.freeze

  SUDOKU_SIZE = POSSIBLE_VALUES.length.freeze

  class InvalidBoardError < TypeError; end

end
