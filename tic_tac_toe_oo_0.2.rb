
# tic_tac_toe_oo_0.2.rb

=begin
  Nouns:
    - x Player
    - x Board
    - x Square

  Verbs:
    - Mark square
    - Check for win
    - Check for empty squares

=end

class Square
  attr_accessor :mark

  def initialize
    self.mark = " "
  end

end

class Board
  attr_accessor :squares

  def initialize
    self.squares = {}
    (1..9).each do |num|
      self.squares[num] = Square.new    # Create hash with nine EMPTY squares
    end
  end
end


class Player
  attr_accessor :name, :shape

  def initialize name
    self.name = name
  end

end

class Game
  attr_accessor :board, :user, :comp
  def initialize
    self.board = Board.new


  end




  def run   # Game engine
    puts "Welcome to Tic Tac Toe!"
    puts "What's your name?"
    print ">>"
    user_name = gets.chomp.capitalize
    self.user = Player.new user_name

    begin
      puts "Pick your shape, X or O"
      print ">>"
      self.user.shape = gets.chomp.capitalize
      puts self.user.shape


    end until user_wants_to_quit

  end


  def mark_square player, board

  end

  def find_winner board
  end

end

game = Game.new
game.run
