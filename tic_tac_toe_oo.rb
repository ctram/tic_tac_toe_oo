# tic_tac_toe_oo.rb

=begin
  Description of game:
    Game starts with first player picking X or O as a shape. X gets to go first. There is a board divided into 9 cells. Each player takes turn marking one cell at a time. When 3 cells that a player has marked lines up into a straight line, that player wins the game. A line can be horizontal, vertical or diagonal, for 8 possible winning lines. When the board is filled up and no one has a winning line, the game is a tie.

  nouns:
    - player
    - cell
    - board
    - line
    - a mark

  verbs:
    - mark



PSEUDO CODE

  welcome screen

  user picks shape

  loop
    x set "x" as player one
    x "x" goes first

    player_x goes
    check for win and board filled
    player_o goes
    check for win and board filled

    goes until something breaks loop
  end until

=end

class Cell
  attr_accessor :mark

  def initialize
    self.mark = " "
  end

end

class Board

  attr_accessor :cells

  def initialize
    self.cells = []

    (1..9).each do |x|
      self.cells << Cell.new
    end
  end
end

class Player
  attr_accessor :sym :ai

  def initialize sym
    self.sym = sym
    self.ai = false
  end

  def mark_cell cell
    cell.mark = self.sym
  end

  def picks_move
    if self.ai = true
      # Is computer, let computer pick random cell
    else
      # Is human

      acceptable_input = %w( 1 2 3 4 5 6 7 8 9)
      input = nil
      input = prompt_then_gets "Choose your move (1 - 9)" until acceptable_input.include?(input)

    end
  end


end

def prompt_then_gets mssg
  puts mssg
  print ">>"
  gets.chomp
end

class Game
  def run
    player_x = Player.new "x"
    player_o = Player.new "o"

    puts "Welcome to Tic Tac Toe!"

    # Let User choose a symbol
    acceptable_input = %w(x o)
    input = nil
    input = prompt_then_gets "Choose your symbol, \"x\" or \"o\". \"x\" goes first." until acceptable_input.include?(input)

    # Set chosen symbols
    input == "x" ? (user = player_x and comp = player_o) : (user = player_o and comp = player_x)

    comp.ai = true



    begin

      player_x.picks_move

      acceptable_input = %w( 1 2 3 4 5 6 7 8 9)
      input = nil
      input = prompt_then_gets "Choose your move (1 - 9)" until acceptable_input.include?(input)



    end until user_wants_to_quit == true



  end
end
