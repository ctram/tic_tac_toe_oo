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
  attr_accessor :mark

  def initialize
    self.mark = "  "
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

  def board_is_filled?
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
  attr_accessor :sym, :ai

  def initialize(sym)
    self.sym = sym
    self.ai = false
  end

  # Mark a cell directly on the board
  # Returns a board
  def mark_cell(board, player_sym)
    if self.ai == true

      # Is computer, let computer pick random cell
      # Computer picks square until comp picks an emtpy square
        begin
          cell_num = [1,2,3,4,5,6,7,8,9].sample
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
  def run
    player_x = Player.new "X"
    player_o = Player.new "O"
    board = Board.new

    system 'clear'
    puts "Welcome to Tic Tac Toe!"

    # Let User choose a symbol
    acceptable_input = %w(x o)
    input = nil
    input = prompt_then_gets "Choose your symbol, \"X\" or \"O\".\n\"X\" goes first." until acceptable_input.include?(input)


    # Set chosen symbols
    input == "x" ? (user, comp = player_x, player_o) : (user, comp = player_o, player_x)

    comp.ai = true


    begin
      begin

        board.draw_board

        board = player_x.mark_cell(board, player_x.sym)

        board.draw_board
        board = player_o.mark_cell(board, player_o.sym)
        board.draw_board

      end until board.board_is_filled? == true or is_there_winner? == true

      if is_there_winner?
        puts "#{winner} wins the game!"
      else
        # Board filled but no winner, so tie.
        puts "There is no winner and no possible moves. The game is a tie."
      end

      acceptable_input = ["q", ""]
      input = prompt_then_gets "Press enter to play again or \"q\" to quit." until
      input == "q" ? (user_wants_to_quit = true) : (user_wants_to_quit = false)

    end until user_wants_to_quit == true

    # TODO: Output who won
    # TODO: Ask whether player wants to play again.

  end

  # Should return a bool
  # TODO: NEXT: code method to determine whether there is a winner.
  def is_there_winner?
    #####
  end

end

game = Game.new
game.run
