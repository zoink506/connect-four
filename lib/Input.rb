module Input
  def get_player_input(board)
    loop do
      puts "Choose a column to drop your color"
      player_input = gets.chomp
      break if verify_input(player_input, 1, 7, 'save', 'exit')
    end

    player_input
  end

  def verify_input(input, min, max, *other)
    if input.to_i <= max && input.to_i >= min
      return true
    elsif other.include?(input)
      return true
    end

    false
  end
end