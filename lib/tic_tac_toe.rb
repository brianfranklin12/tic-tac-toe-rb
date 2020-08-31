WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # left diagonal
  [2,4,6], # right diagonal
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    input.to_i - 1
end
  
def move(board, index, character)
    board[index] = character
end

def position_taken?(board, index)
    if board[index] == " " || board[index] == "" || board[index] == nil
        false
    elsif board[index] == "X" || board[index] == "O"
        true
    end
end

def valid_move?(board, index)
    if index.between?(0, 8) && !position_taken?(board, index)
        true
    else
        false
    end
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
        player = current_player(board)
        move(board, index, player)
        display_board(board)
    else
        turn(board)
    end
end

def turn_count(board)
    counter = 0
    board.each do |turn|
        if turn == "X" || turn == "O"
            counter += 1
        end
    end
    return counter
end

def current_player(board)
    if turn_count(board) % 2 == 0
        return "X"
    else
        return "O"
    end
end

def won?(board)
    WIN_COMBINATIONS.detect do |combo|
      position_taken?(board, combo[0]) && board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]] 
     end
  end
  
  def full?(board)
    WIN_COMBINATIONS.all? do |combo|
      position_taken?(board, combo[0]) && position_taken?(board, combo[1]) && position_taken?(board, combo[2])
    end
  end
  
  def draw?(board)
    full?(board) && !won?(board)
  end
  
  def over?(board)
    won?(board) || full?(board) || draw?(board)
  end
  
  def winner(board)
    if won?(board)
    return board[won?(board)[0]]
    end
  end

  def play(board)
    while !over?(board)
        turn(board)
    end
    if won?(board)
        winz = winner(board)
        puts "Congratulations #{winz}!"
    elsif draw?(board)
        puts "Cat's Game!"
    end
end

##board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
##play(board)