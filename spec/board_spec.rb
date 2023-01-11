require_relative '../lib/Board.rb'

describe Board do
  describe "#check_row" do
    # Returns the amount of coins in a row for each player 
    # Is used to add up score for the computer to make choices

    # No coins
    # [0, 0, 0, 0, 0, 0, 0] = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
    # [1, 0, 1, 0, 1, 0, 1] = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
    # [2, 0, 2, 0, 2, 0, 2] = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
    #                           ^ player one                      ^ player two
    # Two coins
    # [1, 1, 0, 0, 0, 0, 0] = [ { '4' => 0, '3' => 0, '2' => 1 }, { '4' => 0, '3' => 0, '2' => 0 } ]
    # [2, 2, 0, 0, 0, 0, 0] = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 1 } ]
    # [1, 1, 2, 2, 0, 1, 1] = [ { '4' => 0, '3' => 0, '2' => 2 }, { '4' => 0, '3' => 0, '2' => 1 } ]
    
    # Three coins
    # [1, 1, 1, 0, 0, 0, 0] = [ { '4' => 0, '3' => 1, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
    # [2, 2, 2, 0, 0, 0, 0] = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 1, '2' => 0 } ]
    # [1, 1, 1, 2, 2, 1, 1] = [ { '4' => 0, '3' => 1, '2' => 1 }, { '4' => 0, '3' => 0, '2' => 1 } ]

    # Four coins
    # [1, 1, 1, 1, 0, 0, 0] = [ { '4' => 1, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
    # [2, 2, 2, 2, 0, 0, 0] = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 1, '3' => 0, '2' => 0 } ]
    # [1, 1, 1, 1, 0, 2, 2] = [ { '4' => 1, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 1 } ]
    # [2, 2, 2, 2, 1, 1, 1] = [ { '4' => 0, '3' => 1, '2' => 0 }, { '4' => 1, '3' => 0, '2' => 0 } ]

    describe "when no coins are in a row" do
      let(:board) { Board.new }

      it "returns the correct hash" do
        row = [0, 0, 0, 0, 0, 0, 0]
        result = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
        expect(board.check_row(row)).to eq(result)
      end

      it "returns the correct hash" do
        row = [1, 0, 1, 0, 1, 0, 1]
        result = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
        expect(board.check_row(row)).to eq(result)
      end

      it "returns the correct hash" do
        row = [2, 0, 2, 0, 2, 0, 2]
        result = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
        expect(board.check_row(row)).to eq(result)
      end
    end

    describe "when 2 coins are in a row" do
      let(:board) { Board.new }

      it "returns the correct hash" do
        row = [1, 1, 0, 0, 0, 0, 0]
        result = [ { '4' => 0, '3' => 0, '2' => 1 }, { '4' => 0, '3' => 0, '2' => 0 } ]
        expect(board.check_row(row)).to eq(result)
      end

      it "returns the correct hash" do
        row = [2, 2, 0, 0, 0, 0, 0]
        result = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 1 } ]
        expect(board.check_row(row)).to eq(result)
      end

      it "returns the correct hash" do
        row = [1, 1, 2, 2, 0, 1, 1]
        result = [ { '4' => 0, '3' => 0, '2' => 2 }, { '4' => 0, '3' => 0, '2' => 1 } ]
        expect(board.check_row(row)).to eq(result)
      end
    end

    describe "when 3 coins are in a row" do
      let(:board) { Board.new }
      
      it "returns the correct hash" do
        row = [1, 1, 1, 0, 0, 0, 0]
        result = [ { '4' => 0, '3' => 1, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
        expect(board.check_row(row)).to eq(result)
      end

      it "returns the correct hash" do
        row = [2, 2, 2, 0, 0, 0, 0]
        result = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 1, '2' => 0 } ]
        expect(board.check_row(row)).to eq(result)
      end

      it "returns the correct hash" do
        row = [1, 1, 1, 2, 2, 1, 1]
        result = [ { '4' => 0, '3' => 1, '2' => 1 }, { '4' => 0, '3' => 0, '2' => 1 } ]
        expect(board.check_row(row)).to eq(result)
      end
    end

    describe "when 4 coins are in a row" do
      let(:board) { Board.new }

      it "returns the correct hash" do
        # [1, 1, 1, 1, 0, 0, 0] = [ { '4' => 1, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
        row = [1, 1, 1, 1, 0, 0, 0]
        result = [ { '4' => 1, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 0 } ]
        expect(board.check_row(row)).to eq(result)
      end

      it "returns the correct hash" do
        # [2, 2, 2, 2, 0, 0, 0] = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 1, '3' => 0, '2' => 0 } ]
        row = [2, 2, 2, 2, 0, 0, 0]
        result = [ { '4' => 0, '3' => 0, '2' => 0 }, { '4' => 1, '3' => 0, '2' => 0 } ]
        expect(board.check_row(row)).to eq(result)
      end

      it "returns the correct hash" do
        # [1, 1, 1, 1, 0, 2, 2] = [ { '4' => 1, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 1 } ]
        row = [1, 1, 1, 1, 0, 2, 2]
        result = [ { '4' => 1, '3' => 0, '2' => 0 }, { '4' => 0, '3' => 0, '2' => 1 } ]
        expect(board.check_row(row)).to eq(result)
      end

      it "returns the correct hash" do
        # [2, 2, 2, 2, 1, 1, 1] = [ { '4' => 0, '3' => 1, '2' => 0 }, { '4' => 1, '3' => 0, '2' => 0 } ]
        row = [2, 2, 2, 2, 1, 1, 1]
        result = [ { '4' => 0, '3' => 1, '2' => 0 }, { '4' => 1, '3' => 0, '2' => 0 } ]
        expect(board.check_row(row)).to eq(result)
      end

    end
  end
end