module Input
  def get_player_input(board, prompt)
    player_input = ""
    loop do
      puts prompt
      player_input = gets.chomp
      break if verify_input(board, player_input, 1, 7, 'save', 'exit')
    end

    player_input
  end

  def verify_input(board, input, min, max, *other)
    if input.to_i <= max && input.to_i >= min
      # Check if the board has an empty cell to place a circle

      #p board.check_column(input.to_i)
      return board.check_column(input.to_i)

    elsif other.include?(input)
      return true
    end

    false
  end
end