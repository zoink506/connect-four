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
  end

  def play
    round # Check winning condition
  end

  private
  def round
    # Display board
    # Get player input
    # Verify input
    # Act on input

    @board.print_board
    p input = get_player_input(@board, "Choose a column to drop your color (or type 'exit' or 'save')")
    
  end
end