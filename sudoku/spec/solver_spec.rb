require 'spec_helper'

describe Sudoku::Solver do

  let(:solvable_board) do
    complete_board.dup.tap { |board| board.set(1, 1, nil) }
  end

  let(:solver) { described_class.new }

  describe 'solve' do

    it 'should solve a solvable board' do
      board = solver.solve(solvable_board)
      expect(board).to be_valid
    end

    it 'should throw an exception for an unsolvable board' do
      expect { solver.solve(unsolvable_board) }.to raise_exception(Sudoku::Solver::NoSolutionError)
    end

    it 'should solve an empty board' do
      expect(solver.solve(empty_board)).to be_valid
    end

    it 'should return the same board if already solved' do
      expect(solver.solve(complete_board)).to be_valid
      expect(solver.solve(complete_board).matrix).to eq(complete_board.matrix)
    end

  end

  describe 'empty_spaces' do

    it 'should return all indices and all possible volues for an empty board' do
      empty_spaces = solver.send(:empty_spaces, empty_board)
      expect(empty_spaces.length).to eq(Sudoku::SUDOKU_SIZE * Sudoku::SUDOKU_SIZE)
      expect(empty_spaces.map { |s| s[2] }.uniq.flatten).to eq(Sudoku::POSSIBLE_VALUES)
    end

    it 'should return the missing space and possible value' do
      empty_spaces = solver.send(:empty_spaces, solvable_board)
      expect(empty_spaces.length).to eq(1)
      expect(empty_spaces.map { |s| s[2] }.uniq.flatten).to eq([5])
    end

    it 'should return an empty array with a full board' do
      empty_spaces = solver.send(:empty_spaces, complete_board)
      expect(empty_spaces).to eq([])
    end

  end

end
