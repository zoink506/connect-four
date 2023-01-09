require_relative './Board.rb'
require_relative './FileHandler.rb'
require_relative './Input.rb'
require_relative './Computer.rb'

class Game
  include FileHandler
  include Input

  def initialize
    @board = Board.new
    @computer = Computer.new
    @turn = :red
  end

  def play
    loop do
      break if @board.check_winner
      new_round = round
      break if new_round == 'exit'
    end
    @board.print_board
    puts "GAME OVER"
  end

  private
  def round
    # Display board .
    # Get player input .
    # Verify input .
    # Act on input ...

    @board.print_board
    p input = get_player_input(@board, "Choose a column to drop your color (or type 'exit' or 'save')")

    if input == 'save'
      # save game
    elsif input == 'exit'
      # exit game
      return 'exit'
    else
      # place the circle in the correct position
      @board.place_cell(input, @turn)
      
      if @turn == :red
        @turn = :yellow
      elsif @turn == :yellow
        @turn = :red
      end
    end

  end
end