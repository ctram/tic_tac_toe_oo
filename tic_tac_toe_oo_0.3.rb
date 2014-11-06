class Board
  attr_accessor :squares

  def initialize
    self.squares = Hash.new(" ")  # Initial square will always be " "
    # Not really setting the board to be 9 squares, but dimensions of the board will be implicitly 9 because we will only like the players choose from 9 locations.
  end
end

class Player
  attr_accessor :name
end

class Game
  attr_accessor :board, :player_x, :player_o

  def initialize
    self.board = Board.new
  end

  def draw_board
    system 'clear'
    s = self.board.squares
    puts "#{s[1]}  | #{s[2]} | #{s[3]}"
    puts "___|___|___"
    puts "#{s[4]}  | #{s[5]} | #{s[6]}"
    puts "___|___|___"
    puts "#{s[7]}  | #{s[8]} | #{s[9]}"
    puts "   |   |   "

  end

  def run
    puts "Welcome to Tic Tac Toe!"
    puts "What's your name?"
    name = gets.chomp

    user = Player.new(name)
    comp = Player.new("Comp")

    acceptable_input = %w( x o )
    input = nil
    until acceptable_input.include? input
      puts "Choose to play X or O (X gets to go first!):"
      input = gets.chomp.downcase
    end

    # Set shapes players have chosen.
    input == "x" ? (player_x = user; player_o = comp) : (player_x = comp; player_o = user)


    begin
      # TODO: code meat of choosing squares
    end until bool_has_winner or bool_board_filled





  end

end

game = Game.new
game.run
