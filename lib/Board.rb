class Board
  def initialize
    @board = create_board
  end

  def board
    @board
  end

  def find_winner
    true
  end

  def print_board
    @board[0].length.times do |i| 
      print "  #{i+1} "
    end
    print "\n"

    @board.each do |row|
      print "|"
      row.each do |cell|
        if cell.nil?
          print "   |"
        else
          print " #{cell.symbol} |"
        end
      end
      print "\n"
    end
  end

  private
  def create_board
    Array.new(6) { Array.new(7) }
  end
end