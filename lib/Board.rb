require 'colorize'

class Board
  def initialize(preset_board = nil)
    if preset_board.nil?
      @board = Array.new(7) { Array.new(7) { 0 } }
    else
      @board = preset_board
    end
  end

  def print_board
    #@board.each { |row| p row }
    (1..7).each { |num| print "  #{num} " }
    print "\n"

    @board.each_with_index do |row, i|
      print "|"
      row.each do |cell|
        if cell == 0
          print "   |"
        else
          print " #{cell} |"
        end
      end
      print "\n"
    end
  end

  def place_coin(column, color)
    # returns the row and column that the cell was placed

    column = column.to_i
    i = @board.length - 1 # set row to bottom row

    while i >= 0    # loop up the rows to look for empty cell
      if @board[i][column-1] == 0
        @board[i][column-1] = color
        return [i, column-1]
      end

      i -= 1
    end
  end

  def check_column(column)
    # column - 1
    # checks that the top-most cell in that column is 0
    # informs the caller whether a coin can be placed in the column
    if @board[0][column - 1] == 0
      return true
    else
      return false
    end
  end

  def find_winner
    # check rows
    # check columns
    # check diagonals
    rows_checked = check_rows
    rows_checked.each do |row|
      return 1 if row[0]['4'] > 0
      return 2 if row[1]['4'] > 0
    end

    columns_checked = check_columns
    columns_checked.each do |column|
      return 1 if column[0]['4'] > 0
      return 2 if column[1]['4'] > 0
    end

    diagonals_checked_left = check_diagonals(:left)
    diagonals_checked_right = check_diagonals(:right)
    #puts "\n\n"
    #diagonals_checked_left.each { |thing| p thing }
    #puts "\n\n"
    #diagonals_checked_right.each { |thing| p thing }

    diagonals_checked_right.each { |hash| diagonals_checked_left << hash }
    diagonals_checked_left.each do |diagonal|
      return 1 if diagonal[0]['4'] > 0
      return 2 if diagonal[1]['4'] > 0
    end

    nil
  end

  def check_diagonals(dir)
    padding = @board.length - 1
    padded_matrix = []
  
    @board.each do |row|
      inverse_padding = @board.length - padding

      if dir == :left
        padded_matrix << ([nil] * inverse_padding) + row + ([nil] * padding)
      elsif dir == :right
        padded_matrix << ([nil] * padding) + row + ([nil] * inverse_padding)
      end

      #puts "padding: #{padding}"
      #puts "inverse_padding: #{inverse_padding}"
      #padded_matrix.each { |row| p row }
      padding -= 1    
      #puts "\n"
    end
  
    #padded_matrix.transpose.each { |row| p row }
    #puts "\n\n"
    diagonals = padded_matrix.transpose.map(&:compact)
    diagonals_checked = []

    diagonals.each do |diagonal|
      diagonals_checked << check_row(diagonal)
    end

    diagonals_checked
  end

  def check_columns
    columns = []

    column = 0
    while column < @board[0].length
      column_arr = []
      @board.each_with_index do |row|
        column_arr << row[column]
      end

      columns << check_row(column_arr)
      #p column_arr
      column += 1
    end

    columns
  end

  def check_rows
    rows = []
    @board.each do |row|
      row_check = check_row(row)
      rows << row_check
    end

    return rows
  end

  def check_row(arr)
    # returns the amount of four, three, two, one in a row of the same color
    # does this so the computer can make decisions
    return_array = [
      { '4' => 0, '3' => 0, '2' => 0 },
      { '4' => 0, '3' => 0, '2' => 0 }
    ]

    count = 0
    coin = 0
    arr.each_with_index do |cell, i|
      if cell == 0
        # If previous cell was a coin, add one to the corresponding key if count is 2, 3, or 4.
        # If previous cell was not a coin, set color and count to 0.
        if coin != 0
          return_array[coin-1][count.to_s] += 1 if count >= 2 && count <= 4
        end

        count = 0
        coin = 0
      elsif cell != 0

        if coin == cell
          count += 1

          if i == arr.length - 1
            return_array[coin-1][count.to_s] += 1 if count >= 2 && count <= 4
          end
        else
          return_array[coin-1][count.to_s] += 1 if count >= 2 && count <= 4
          count = 1
          coin = cell
        end
      end
    end

    return_array
  end
end