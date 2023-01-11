This project is a simple connect four game on a 7x6 grid.
the Game class controls the flow of the game. It creates a Board instance and a Computer instance.
The Board stores a 2D array. Empty values in the grid are represented by the value 0.
Player 1 is represented by a 1, and player 2 (the computer) is represented by a 2.

To check if the game has been won, Board#find_winner looks at every row, column, and diagonal.
It counts all the 2 in a row, 3 in a row, and 4 in a row. If the 4 in a row value is >= 1, the game has been won.
The bot uses these values to calculate a score for any particular board configuration.
It creates a new board for each possible move the bot can make (7 total, 1 for each column)
It places a coin in the correct column for each board, then calculates the score for each board.
It takes the board with the highest score, and places the coin in the column in the real board.
This bot could use some more work, for example using a minimax algorithm, and adding defensive moves, so that
the bot can block the player from placing 4 in a row and winning, which it currently cannot do.