require 'spec_helper'

describe Sudoku::Board do

  describe 'valid?' do

    it 'should be falsey when matrix dimensions are incorrect' do
      expect(described_class.new([[1],[2,3]]).valid?).to be_falsey
    end

    it 'should be falsey when matrix contains invalid values' do
      board = empty_board.tap { |board| board[0][0] = 'x' }
      expect(described_class.new(board).valid?).to be_falsey
    end

    it 'should be falsey when matrix contains duplicate values' do
      board = Sudoku::POSSIBLE_VALUES.map { |i| Array.new(Sudoku::SUDOKU_SIZE, i) }
      expect(described_class.new(board).valid?).to be_falsey
    end

    it 'should be truthy with an empty matrix' do
      expect(described_class.new(empty_board).valid?).to be_truthy
    end

    it 'should be valid with a valid matrix' do
      expect(described_class.new(VALID_BOARD).valid?).to be_truthy
    end

  end

end
