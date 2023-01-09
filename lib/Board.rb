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
    # Returns :red if red has won, :yellow if yellow has won, and nil if neither has won

    # check rows for 4 in a row
    # check columns for 4 in a row
    # check diagonals for 4 in a row

    rows_clear = check_rows
    columns_clear = check_columns
    diagonal_left = check_diagonal_left


    return rows_clear if !rows_clear.nil?
    return columns_clear if !columns_clear.nil?


  end

  def check_diagonal_left
    
  end

  def check_rows
    @board.each do |row|
      #count = 0   # restart counting from 0 at start of new row
      #color = nil # keeps track of the color of the line of ?coins?

      checked_row = check_row(row)
      return checked_row if checked_row != nil
    end

    nil
  end

  def check_row(row)
    # checks a single array (representing a row/column) for 4 in a row
    count = 0   # restart counting from 0 at start of new row
    color = nil # keeps track of the color of the line of ?coins?

    row.each do |cell|
      if !cell.nil?
        # cell is occupied by a red or yellow coin
        # check if the coin is the same color as the coin behind it (color variable)

        if color.nil? 
          # Either first cell, or previous cell was empty (nil)
          color = cell.value
          count = 1
        else 
          # previous cell had a coin in it
          if color == cell.value
            # both this cell and the one behind it are the same color
            count += 1
          else
            # this cell and the one behind are different colors
            count = 1
            color = cell.value
          end
        end
      else # reset count and color if there is an empty space
        count = 0
        color = nil
      end

      if count >= 4
        #puts "COUNT IS >= 4"
        return color
      end
    end

    nil
  end

  def check_columns
    column = 0
    while column < @board[0].length # number of columns on board
      current_column = []
      @board[0][column]

      j = 0
      while j < @board.length
        current_column << @board[j][column]
        j += 1
      end

      # check for a winner in the column
      column_check = check_row(current_column)
      return column_check if !column_check.nil?

      column += 1
    end

    nil
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