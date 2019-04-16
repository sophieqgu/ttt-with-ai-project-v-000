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
  
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end 

  def current_player 
    board.turn_count % 2 == 0 ? player_1 : player_2
  end 
  
  def won?
    WIN_COMBINATIONS.select do |combo| 
      combo.all? do |i|
        board.cells[i] == "X" || board.cells[i] == "O"
      end 
    end 
  end 
  
  def draw?
    !won? && board.full?
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
    current_move = current_player.move(@board)
    if !board.valid_move?(current_move)
      turn
    else
      puts "Turn: #{@board.turn_count+1}\n"
      @board.display
      @board.update(current_move, player)
      puts "#{player.token} moved #{current_move}"
      @board.display
      puts "\n\n"
    end 
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
      
      
  
  