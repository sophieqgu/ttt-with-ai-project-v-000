class Game 
  attr_accessor :board, :player_1, :player_2
  
  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]
  
  def initialize(board = Board.new, player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"))
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end 

  def current_player 
    "X" if @board.cells.count("X") == @board.cells.count("O")
    "O" if @board.cells.count("X") > @board.cells.count("O")
  end 
  
  def won?
    !draw? && WIN_COMBINATIONS.select do |combo| 
      combo.all? do |i|
        @board.cells[i] == "X" || @board.cells[i] == "O"
      end 
    end 
  end 
  
  def draw?
    !won? && @board.cells.count {|p| p == "X"} == @board.cells.count {|p| p == "O"}
  end 
  
  def over?
    won? || draw?
  end 
  
  def winner?
    "X" if won? && current_player == "O"
    "O" if won? && current_player == "X"
    nil 
  end 
    
  def turn 
    player_1.move if current_player == player_1.token
    player_2.move if current_player == player_2.token 
  end 
  
  def play
    while !over?
      turn
    end 
    if won? 
      puts "Congratulations #{winner?}!"
    end 
    elsif draw?
      puts "Cat's Game!"
    end 
  end
end 
      
      
  
  