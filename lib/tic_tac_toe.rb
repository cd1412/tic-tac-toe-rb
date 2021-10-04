# We're building helper methods. 
# We use rspec spec/01_tic_tac_toe_spec.rb in terminal to test our methods.
# First, define a constant called WIN_COMBINATIONS
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]
# Remember to save these changes
# Next, we define display_board method that accepts the board argument
# prints out the current board
# We define a board variable before that
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
# Now, define the display_board method
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end
# Next, we define the input_to_index method that takes the user_input
# converts it to an integer, and substract 1 because player sees 1-9
# but index starts at 0-8
def input_to_index(user_input)
    user_input.to_i - 1
  end
  # Next, we define the move method that takes in 3 arguments: the board array,
  # the index on board that user wants to fill out with "X" or "O"
  # and the user's character of either "X" or "O" but no need to set it as either one like in previous lab
  def move(board, index, value)
    board[index] = value
  end
  # Next, we define the position_taken? method that checks if user's chosen spot
  # is vacant or filled with either "X" or "O" and return true/false
  def position_taken?(board, index)
    if board[index] == " " || board[index] == "" || board[index] == nil
        false
    else 
        true
    end
end
# Next, we define the valid_move? method that returns true/false
# move is valid in 2 conditions: present on the game board 
# and not already taken. No need to define position_taken? inside valid_move?
def valid_move?(board, index)
    if index.between?(0, 8) && !position_taken?(board, index)
        true
    end
end
# Next, we define the turn_count method that returns the number of turns that have been played
# set a counter and keep it counting
def turn_count(board)
    counter = 0
    board.each do |turn|
        if turn == "X" or turn == "O"
            counter += 1
        end
    end
    counter
end
# Next, we define the current_player method that uses turn_count method
# to determine if it's "X" turn or "O" turn
# if the number of turns divisible by 2 (or % 2 == 0), it's "X"'s turn
#if not divisible by 2, it's "O" turn
def current_player(board)
    if turn_count(board) % 2 == 0
        "X"
    else
        "O"
    end
end
# Next, we define turn method for one single complete turn follow these
# asking user for their move, getting input, converting input to index
# if move is valid - make move for index and show board
# else - ask for input again until you get a valid move
# end
def turn(board)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
        move(board, index, current_player(board))
    # It won't work if you write move(board, index, value) here like you did in previous move method lab
    # it will give you NameError asking about an undefined variable called value there
    # because at this point, you have to use current_player(board) method 
    # to get the most current and precise value of a token "X" or "O"    
    else 
        turn(board)
    end
    display_board(board)
end    
# Next, we define won? method
# use WIN_COMBINATIONS constant
# if there's a win meaning one of the item on list of WIN_COMBINATIONS
# return the array of indexes of the win
# if not, return false
def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      #You can also do WIN_COMBINATIONS.any? do |win_combination|
      # win_combination.all? do |win_index|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
  
       position_1 = board[win_index_1]
       position_2 = board[win_index_2]
       position_3 = board[win_index_3]
  
       if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
        # You have to include && position_taken?(board, win_index_1)
        return win_combination
       end
      end
       return false
      end
# Next, we define the full? method  
# if every element on board contains either "X" or "O" return true  
  def full?(board)
    board.all? do |index|
    index == "X" or index == "O"
    end
  end
# Next, we define the draw? method  
# if not won and is full, return true
#if not won and not full, or won (and not full), return false
  def draw?(board)
  if !won?(board) && full?(board)
    # Another way to write it is !won?(board) meaning won?(board) == false
    true
  elsif !won?(board) 
    # If write elsif !won?(board) && !full?(board), you'll get a FailureError
    # saying failed calls full? and expected 1 time with arguments looked like
    # a full board, but not won board and received 2 times with argumenst
    # like that, so we have to exclude !full?(board)
    false
  else won?(board)
    false
  end
  end
# Next, we define the over? method
# if won, draw, or full, return true
# but write code in order of draw, won, full to pass  
  def over?(board)
  if draw?(board) == true or won?(board) or full?(board)
    # The line above will only pass with this order of draw, won, and then full. 
    # When the order was won, full, and draw, it did not pass
    true
  else
    false
  end
  end
# Next, we define the winner method
# return the token of either "X" or "O" that has won the game  
  def winner(board)
    if won?(board)
      # When you wrote won?(board) == true, it did not pass
      return board[won?(board)[0]]
    end
  end
# Next, we define the play method which is the main method of ttt application
# pseudocode: 
# until the game is over
#  take turns
# end
# if game won
#  congratulates winner
# elsif game draw
#  tell player it's a draw
# end
# run the test for the play method by rspec spec/02_play_spec.rb
def play(board)
    until over?(board)
        turn(board)
    end

    if won?(board)
        winner(board) == "X" or winner(board) == "O"
        # Here, you have to explicitly say winner(board) == "X" or winner(board) == "O"
        puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
        puts "Cat's Game!"
    end
end    