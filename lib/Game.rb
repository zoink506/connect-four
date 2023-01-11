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
    @turn = 1
  end
  
  def play 
    loop do
      new_round = round
      break if !@board.find_winner.nil? || new_round == 'exit'
    end
    @board.print_board
  end

  private
  def round
    # get user input
    # verify user input
    # place coin in correct location
    @board.print_board
    if @turn == 1
      player_input = get_player_input(@board, "Enter a column to place a coin (or type 'exit' or 'save')")
      if player_input == 'exit'
        # exit game
        return player_input
      elsif player_input == 'save'
        # save game
        return player_input
      else
        # place cell
        placed_cell = @board.place_coin(player_input, @turn)
        p placed_cell

        @turn = 2
      end 
    else
      # computers turn to move
      sleep(1)

      #random_column = rand(1..7).to_s
      #@board.place_coin(random_column, @turn)
      optimal_move = @computer.choose_move(@board)
      puts "Optimal move: #{optimal_move}"
      @board.place_coin(optimal_move['column'], @turn)

      @turn = 1
    end


  end

end