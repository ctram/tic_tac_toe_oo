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

# TODO: Program complete - run errors.
require 'pry'

class Square
  attr_accessor :mark

  def initialize
    self.mark = " "
  end

end

class Board
  attr_accessor :squares
  # @sqaures =

  def initialize
    self.squares = Hash.new
    (1..9).each do |num|
      self.squares[num] = Square.new    # Create hash with nine EMPTY squares
    end
    ###binding.pry

  end
end

class Player
  attr_accessor :name, :shape

  def initialize name
    self.name = name
    self.shape = ""
  end

end

class Game
  attr_accessor :board, :user, :comp, :name
  # @board = Board.new

  def initialize
    self.board = Board.new
    ##binding.pry
  end

  def draw_board
    system 'clear'
    s = self.board.squares
    puts "#{s[1].mark}  | #{s[2].mark} | #{s[3].mark}"
    puts "___|___|___"
    puts "#{s[4].mark}  | #{s[5].mark} | #{s[6].mark}"
    puts "___|___|___"
    puts "#{s[7].mark}  | #{s[8].mark} | #{s[9].mark}"
    puts "   |   |   "

  end

  def check_for_winner_and_full_board board
    if find_winner(board) != nil
      bool_there_is_winner = true
      winner = find_winner(board)
    end
    bool_board_is_full = board_is_full?(board)
    return bool_there_is_winner, winner, bool_board_is_full
  end

  def mark_square player, board, square_location
    # Check if this is the comp, if so, let the comp
    # FIXME: how to test that player is the same as player_x? player_x is class Player.
    player.shape == "X" ? sym = "X" : sym = "O"

    self.board.squares[square_location.to_i].mark = sym
  end

  def find_winner board
    # If X wins, then there will be more X's on the board then O's
    num_xs = 0
    num_os = 0

    board.squares.values.each do |value|
      if value == "X"
        num_xs += 1
      elsif value == "O"
        num_os += 1
      end
    end

    if num_xs > num_os
      return "player_x"
    else
      return "player_o"
    end
  end

  def board_is_full? board
    count = 0
    board.squares.each do |k,v|
      if v == " "
        count +=1
      end
    end

    count == 0 ? (return true) : (return false)

  end

  # Returns player_x or player_o or nil
  def find_winner board
    b = board.squares
    if (( b[1] == b[2] and b[2] == b[3] ) and b[1] != " " ) or
        (( b[4] == b[5] and b[5] == b[6] ) and b[4] != " " ) or
        (( b[7] == b[8] and b[8] == b[9] ) and b[7] != " " ) or

        (( b[1] == b[4] and b[4] == b[7] ) and b[1] != " " ) or
        (( b[2] == b[5] and b[5] == b[8] ) and b[2] != " " ) or
        (( b[3] == b[6] and b[6] == b[9] ) and b[3] != " " ) or

        (( b[1] == b[5] and b[5] == b[9] ) and b[1] != " " ) or
        (( b[7] == b[5] and b[5] == b[3] ) and b[7] != " " )

      num_xs = 0
      num_os = 0

      b.each do |k,v|
        if v != " "
          if v == "X"
            num_xs += 1
          else
            num_os += 1
          end
        end
      end

      if num_xs > num_os
        # X won, since X goes first, X will always be ahead by one move when he wins
        return player_x
      else
        return player_o
      end
    else
      return nil
    end
    # return symbol that won or nil
  end

  def run   # Game engine
    puts "Welcome to Tic Tac Toe!"
    puts "What's your name?"
    print ">>"
    user_name = gets.chomp.capitalize
    self.user = Player.new user_name
    self.comp = Player.new "Computer"
    ###binding.pry

    begin
      puts "Pick your shape, X or O"
      print ">>"
      self.user.shape = gets.chomp.capitalize  # Set User's shape
      ####binding.pry
      # FIXME: under defined shape= method??
      self.user.shape == "X" ? self.comp.shape = "O" : self.comp.shape = "X"  # Set comp's shape
      bool_there_is_winner = false
      bool_board_is_full = false

      # Set player_x and player_o
      self.user.shape == "X" ? player_x = self.user : player_o = self.user
      player_x == self.user ? player_o = self.comp : player_x = self.comp

      # Each player takes turn picking a square to mark
      begin
        # Player who picked "X" goes first
        if player_x == self.user
          # User goes first, followed by Comp
          acceptable_input = %w(1 2 3 4 5 6 7 8 9)
          square_location = 0

          draw_board
          until acceptable_input.include? square_location and self.board.squares[square_location.to_i].mark == " "
            binding.pry
            puts "Pick a square (1 - 9)"
            square_location = gets.chomp
            # ###binding.pry
          end
          mark_square(player_x, self.board, square_location)
          draw_board
          bool_there_is_winner, winner, bool_board_is_full = check_for_winner_and_full_board(board)

          # Comp goes
          square_location = 0
            binding.pry
          until self.board.squares[square_location.to_i].mark == " "
            binding.pry
            square_location = acceptable_input.sample
          end
          mark_square(player_o, self.board, square_location)
          draw_board

          bool_there_is_winner, winner, bool_board_is_full = check_for_winner_and_full_board(board)

        else
          # Comp goes first, randomly picks a square
          square_location = 0
          until self.board.squares[square_location.to_i].mark == " "
            square_location = acceptable_input.sample
          end
          mark_square(player_x, self.board, square_location)
          draw_board

          bool_there_is_winner, winner, bool_board_is_full = check_for_winner_and_full_board(board)

          # User goes
          acceptable_input = %w(1 2 3 4 5 6 7 8 9)
          square_location = 0
          until acceptable_input.include? square_location and self.board.squares[square_location.to_i].mark == " "
            puts "Pick a square (1 - 9)"
            square_location = gets.chomp
          end
          mark_square(player_o, self.board, square_location)
          draw_board

          bool_there_is_winner, winner, bool_board_is_full = check_for_winner_and_full_board(board)

        end

      end until bool_there_is_winner or bool_board_is_full

      # TODO: display winner
      winner == self.user ? winner = self.user.name : winner = self.comp.name
      puts "The winner is #{winner}!"
      puts "To play again, press enter. Otherwise press anything else to quit."

      if gets.chomp != "\n"
        user_wants_to_quit = true
      end
    end until user_wants_to_quit

  end

end


game = Game.new
game.run
