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

    x player_x goes
    x check for win and board filled
    x player_o goes
    x check for win and board filled

    goes until something breaks loop
  end until

=end
require 'pry'

def prompt_then_gets mssg
  puts mssg
  print ">>"
  gets.chomp.downcase
end

class Cell
  include Comparable

  attr_accessor :mark

  def initialize
    self.mark = "  "
  end

  def <=>(other_cell)
    if self.mark == other_cell
      return 0
    end
  end

end

# To implement Line class, you'll need to change the code in Board -- Board will need to be defined as Lines of Cells, so 8 lines
class Line
end


class Board

  attr_accessor :cells

  def initialize
    self.cells = []

    (1..9).each do |x|
      self.cells << Cell.new
    end
  end

      def is_filled?
    empty_cells = self.cells.select do |cell|
                    cell.mark == " "
                  end

    empty_cells.size == 0 ? true : false
  end


  def draw_board
    system 'clear'
    puts self.cells[0].mark + "    |   " + self.cells[1].mark + " |    " + self.cells[2].mark
    puts "-----|------|-----"
    puts self.cells[3].mark + "    |   " + self.cells[4].mark + " |    " + self.cells[5].mark
    puts "-----|------|-----"
    puts self.cells[6].mark + "    |    " + self.cells[7].mark + " |    " + self.cells[8].mark
  end

end

class Player
  attr_accessor :sym, :ai, :name

  def initialize(sym, name)
    self.sym = sym
    self.ai = false
    self.name = name
  end

  # Mark a cell directly on the board
  # Returns a board
  def mark_cell(board, player_sym)
    if self.ai == true

      # Is computer, let computer pick random cell
      # Computer picks square until comp picks an emtpy square
        begin
          cell_num = [0,1,2,3,4,5,6,7,8].sample
        end until board.cells[cell_num].mark == "  "

        board.cells[cell_num].mark = player_sym

        board
    else
      # Is human

      acceptable_input = %w( 1 2 3 4 5 6 7 8 9)
      cell_num = nil
      cell_num = (prompt_then_gets "Choose your move (1 - 9)") until (acceptable_input.include?(cell_num) and board.cells[cell_num.to_i].mark == "  ")

      board.cells[cell_num.to_i].mark = player_sym

      board
    end
  end

end

class Game
  def is_there_winner?(board)
        # Horizontal wins
    if  (board.cells[0].mark == board.cells[1].mark and board.cells[1].mark == board.cells[2]) or
        (board.cells[3].mark == board.cells[4].mark and board.cells[4].mark == board.cells[5]) or
        (board.cells[6].mark == board.cells[7].mark and board.cells[7].mark == board.cells[8]) or

        # Vertical wins
        (board.cells[0].mark == board.cells[3].mark and board.cells[3].mark == board.cells[6]) or
        (board.cells[1].mark == board.cells[4].mark and board.cells[4].mark == board.cells[7]) or
        (board.cells[2].mark == board.cells[5].mark and board.cells[5].mark == board.cells[8]) or

        (board.cells[0].mark == board.cells[4].mark and board.cells[4].mark == board.cells[8]) or
        (board.cells[6].mark == board.cells[4].mark and board.cells[4].mark == board.cells[2])
        ## End condition

        true
    else
        false
    end
  end

  # Returns string of who won
  def find_winner(board)
    xs = board.cells.select do |cell|
          cell.mark = "x"
        end

    num_x = xs.size

    os = board.cells.select do |cell|
          cell.mark = "o"
        end

    num_o = os.size

    # If X wins, there will be more x's on the board, since x always goes first
    if num_x > num_o
      return "player_x"
    else
      return "player_o"
    end
  end

  def run

    system 'clear'
    puts "Welcome to Tic Tac Toe!"

    user_name = prompt_then_gets "What's your name?"
    user_name.capitalize!
    puts

    # Let User choose a symbol
    acceptable_input = %w(x o)
    input = nil
    input = (prompt_then_gets "Choose your symbol, \"X\" or \"O\".\n\"X\" goes first.") until acceptable_input.include?(input)


    if input == "x"
      player_x = Player.new "X", user_name
      player_o = Player.new "O", "Computer"
      player_o.ai = true
      board = Board.new
    else
      player_x = Player.new "X", "Computer"
      player_x.ai = true
      player_o = Player.new "O", user_name
      board = Board.new
    end

    begin
      begin

        board.draw_board
        board = player_x.mark_cell(board, player_x.sym)

        board.draw_board
        board = player_o.mark_cell(board, player_o.sym)
        board.draw_board

      end until board.is_filled? == true or is_there_winner?(board) == true

      winner = find_winner(board)
      winner == "player_x" ? (winner = player_x.name) : (winner = player_o.name)

      if is_there_winner?(board)
        puts "#{winner} wins the game!"
      elsif !board.is_filled?
        # Board filled but no winner, so tie.
        puts "There is no winner and no possible moves. The game is a tie."
      end

      acceptable_input = ["q", ""]
      input = prompt_then_gets("Press enter to play again or \"q\" to quit.") until acceptable_input.include?(input)

      user_wants_to_quit = true if input == "q"


    end until user_wants_to_quit == true


  end


end

game = Game.new
game.run
