require_relative './Cell.rb'

class Board
  def initialize(preset_board = nil)
    if preset_board.nil?
      @board = create_board
    else
      @board = preset_board
    end
  end

  def board
    @board
  end

  def check_winner
    false
  end

  def place_cell(column, color)
    column = column.to_i
    @board.reverse.each do |row|
      cell = row[column-1]
      
      if cell.nil?
        row[column-1] = Cell.new(color)
        break
      end

    end
  end

  def check_column(column)
    # Returns true if column has an empty space available
    # Returns false if column is completely filled
    if @board[0][column-1].nil?
      return true
    else
      return false
    end
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