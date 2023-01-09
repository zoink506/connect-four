require_relative '../lib/Board.rb'
require_relative '../lib/Cell.rb'

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
end