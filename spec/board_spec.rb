require_relative '../lib/Board.rb'
require_relative '../lib/Cell.rb'
require 'yaml'

describe Board do
  describe "#check_column" do
    subject(:new_board) { described_class.new([
      [nil, nil, Cell.new(:red), nil, nil, nil, nil],
      Array.new(7),
      Array.new(7),
      Array.new(7),
      Array.new(7),
      Array.new(7)
    ]) }

    it "returns false when the top cell of specified column is not nil" do
      is_empty = new_board.check_column(3)
      expect(is_empty).to eq(false)
    end

    it "returns true when the top cell of specified column is nil" do
      is_empty = new_board.check_column(4)
      expect(is_empty).to eq(true)
    end
  end

  describe "#place_cell" do
    subject(:board) { described_class.new }
    it "returns the correct board after placing new circle" do
      # Turns the array into YAML object
      # Test does not pass comparing the arrays themselves because the object ID of the cells
      # are different, despite having the same content

      board.place_cell(3, :red)
      expect(board.board.to_yaml).to eq([
        Array.new(7),
        Array.new(7),
        Array.new(7),
        Array.new(7),
        Array.new(7),
        [nil, nil, Cell.new(:red), nil, nil, nil, nil]
      ].to_yaml)
    end

    it "stacks cells correctly" do
      board.place_cell(3, :red)
      board.place_cell(3, :yellow)
      expect(board.board.to_yaml).to eq([
        Array.new(7),
        Array.new(7),
        Array.new(7),
        Array.new(7),
        [nil, nil, Cell.new(:yellow), nil, nil, nil, nil],
        [nil, nil, Cell.new(:red), nil, nil, nil, nil]
      ].to_yaml)
    end
  end
end