class Computer
  def choose_move(board)
    # Create a new board for each possible move
    # place a coin into the proper spot on the new board
    # evaluate the new board, return a score
    # choose the highest score
    # place the coin in that column

    # closer to the center, the better
    # use a multiplier to make the score less as the column gets further from center
    # columns:
    #   4: 1.3x
    #   3-5: 1.1x
    #   2-6: 1.0x
    #   1-7: 0.9x

    #scores = board_evaluation(board)
    #player_score = scores[0]
    #computer_score = scores[1]

    all_scores = []
    (1..7).each do |i|
      if board.check_column(i) == true
        new_board = Marshal.load(Marshal.dump(board))
        new_board.place_coin(i, 2)

        puts "Possible move #{i}"
        #new_board.print_board
        board_score = board_evaluation(new_board)
        board_score = board_score[1]

        # use multiplier depending on i value
        if i == 4
          board_score *= 1.3
        elsif i >= 3 && i <= 5
          board_score *= 1.1
        elsif i >= 2 && i <= 6
          board_score *= 1.0
        elsif i >= 1 && i <= 7
          board_score *= 0.9
        end
        board_score = { 'column' => i, 'score' => board_score }

        puts "  total score: #{board_score}"
        all_scores << board_score

      end
    end
    puts "all_scores = #{all_scores}"
    all_scores.max_by { |hash| hash['score'] }

  end
  
  def board_evaluation(board)
    # Gathers all the 'x' in a row for both the computer and the player
    # multiplies the amount of 'x' in a rows by it's respective score value
    # returns the score for the supplied board 
    # example: 
    #   6 two in a row 
    #   2 three in a row
    #   0 four in a row
    #   6 * 3 = 18
    #   2 * 15 = 30
    #   30 + 18 = 48
    #   48 total score
    rows_checked = board.check_rows
    columns_checked = board.check_columns
    diagonals_checked_left = board.check_diagonals(:left)
    diagonals_checked_right = board.check_diagonals(:right)
    diagonals_checked_right.each { |hash| diagonals_checked_left << hash }

    two_in_a_row_player = 0
    three_in_a_row_player = 0
    four_in_a_row_player = 0
    
    two_in_a_row_computer = 0
    three_in_a_row_computer = 0
    four_in_a_row_computer = 0

    #rows_checked.each { |thing| p thing }

    rows_checked.each do |arr|
      two_in_a_row_player += arr[0]['2']
      three_in_a_row_player += arr[0]['3']
      four_in_a_row_player += arr[0]['4']

      two_in_a_row_computer += arr[1]['2']
      three_in_a_row_computer += arr[1]['3']
      four_in_a_row_computer += arr[1]['4']
    end

    columns_checked.each do |arr|
      two_in_a_row_player += arr[0]['2']
      three_in_a_row_player += arr[0]['3']
      four_in_a_row_player += arr[0]['4']

      two_in_a_row_computer += arr[1]['2']
      three_in_a_row_computer += arr[1]['3']
      four_in_a_row_computer += arr[1]['4']
    end

    diagonals_checked_left.each do |arr|
      two_in_a_row_player += arr[0]['2']
      three_in_a_row_player += arr[0]['3']
      four_in_a_row_player += arr[0]['4']

      two_in_a_row_computer += arr[1]['2']
      three_in_a_row_computer += arr[1]['3']
      four_in_a_row_computer += arr[1]['4']
    end

    total_score_player = 1
    total_score_computer = 1
    total_score_player += (two_in_a_row_player * 3) + (three_in_a_row_player * 15) + (four_in_a_row_player * 1000)
    total_score_computer += (two_in_a_row_computer * 3) + (three_in_a_row_computer * 15) + (four_in_a_row_computer * 1000)

    #puts "\n"
    #puts "player"
    #puts "  two in a row: #{two_in_a_row_player}"
    #puts "  three in a row: #{three_in_a_row_player}"
    #puts "  four in a row: #{four_in_a_row_player}"
    #puts "  total_score: #{total_score_player}"
    #puts"\n"

    #puts "\n"
    #puts "computer"
    #puts "  two in a row: #{two_in_a_row_computer}"
    #puts "  three in a row: #{three_in_a_row_computer}"
    #puts "  four in a row: #{four_in_a_row_computer}"
    #puts "  total_score: #{total_score_computer}"
    #puts "\n"

    return [total_score_player, total_score_computer]
  end
end