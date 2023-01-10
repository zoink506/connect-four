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

  describe "#check_winner" do
    describe "When 4 cells are in a row horizontally" do
      subject(:board) { described_class.new }

      it "returns :red if the 4 cells are all red" do
        board.place_cell(1, :red)
        board.place_cell(2, :red)
        board.place_cell(3, :red)
        board.place_cell(4, :red)
        expect(board.check_winner).to eq(:red)
      end

      it "returns :yellow if the 4 cells are yellow" do
        board.place_cell(1, :yellow)
        board.place_cell(2, :yellow)
        board.place_cell(3, :yellow)
        board.place_cell(4, :yellow)
        expect(board.check_winner).to eq(:yellow)
      end

      it "returns nil if there is no 4 in a row" do
        expect(board.check_winner).to eq(nil)
      end

    end

    describe "When 4 cells are in a row vertically" do
      subject(:board) { described_class.new }
      it "returns :red if the 4 cells are all red" do
        board.place_cell(1, :red)
        board.place_cell(1, :red)
        board.place_cell(1, :red)
        board.place_cell(1, :red)
        expect(board.check_winner).to eq(:red)
      end

      it "returns :yellow if the 4 cells are yellow" do
        board.place_cell(1, :yellow)
        board.place_cell(1, :yellow)
        board.place_cell(1, :yellow)
        board.place_cell(1, :yellow)
        expect(board.check_winner).to eq(:yellow)
      end

      it "returns nil if there is no 4 in a row" do
        expect(board.check_winner).to eq(nil)
      end

    end

    describe "When 4 coins are in a row diagonally" do
      describe "Left facing diagonal" do
        subject(:board) { described_class.new([
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, Cell.new(:red), nil, nil, nil, nil, nil],
          [nil, nil, Cell.new(:red), nil, nil, nil, nil],
          [nil, nil, nil, Cell.new(:red), nil, nil, nil],
          [nil, nil, nil, nil, Cell.new(:red), nil, nil]
        ]) }

        it "returns :red when 4 red coins are on a left facing diagonal" do
          expect(board.check_winner).to eq(:red)
        end
      end

      describe "Right facing diagonal" do 
        subject(:board) { described_class.new([
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, Cell.new(:yellow), nil, nil],
          [nil, nil, nil, Cell.new(:yellow), nil, nil, nil],
          [nil, nil, Cell.new(:yellow), nil, nil, nil, nil],
          [nil, Cell.new(:yellow), nil, nil, nil, nil, nil]
        ]) }

        it "returns :yellow when 4 yellow coins are on a right facing diagonal" do
          expect(board.check_winner).to eq(:yellow)
        end
      end
    end
  end
end