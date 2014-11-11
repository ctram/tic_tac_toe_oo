
class Board
  attr_accessor :squares

  def initialize
    self.squares = Hash.new
    (1..9).each do |i|
      self.squares[i] = " "   # All squares are initially empty/single space.
    end
  end
end

class Player
  attr_accessor :name

  def initialize name
    self.name = name
  end
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

  def comp_picks_square comp
    comp == player_x ? comp_sym = "X" : comp_sym = "O"

    # Comp randomly picks a square
    begin
      comps_choice = %w(1 2 3 4 5 6 7 8 9).sample.to_i
    end until self.board.squares[comps_choice] == " "

    # Comp marks the square
    self.board.squares[comps_choice] = comp_sym
  end

  def user_picks_square user
    begin
      puts "Pick a square to mark (1-9):"
      print ">>"
      users_choice = gets.chomp.to_i
    end until self.board.squares[users_choice] == " "

    user == player_x ? user_sym = "X" : user_sym = "O"

    self.board.squares[users_choice] = user_sym
  end

  def find_winner
    s = self.board.squares

    if  (
        # Horizontal wins
        (s[1] == s[2] and s[2] == s[3] and s[3] != " ") or
        (s[4] == s[5] and s[5] == s[6] and s[6] != " ") or
        (s[7] == s[8] and s[8] == s[9] and s[9] != " ") or

        # Vertical wins
        (s[1] == s[4] and s[4] ==s[7] and s[7] != " ") or
        (s[2] == s[5] and s[5] == s[8] and s[8] != " ") or
        (s[3] == s[6] and s[6] == s[9] and s[9] != " ") or

        # Diagonal wins
        (s[1] == s[5] and s[5] == s[9] and s[9] != " ") or
        (s[3] == s[5] and s[5] == s[7] and s[7] != " ")
                                                                )

      # There is a winner, deteminer who it is.
      # If X won, then there will be more X's on the board, since X goes first and will always be ahead one move on his win.
      num_xs = 0
      num_os = 0

      self.board.squares.each do |k,v|  # squares is a HASH
        v == "X" ? num_xs += 1 : nil
        v == "O" ? num_os += 1 : nil
      end

      num_xs > num_os ? (return  self.player_x) : (return  self.player_o)
    end
  end

  def is_board_full?
    empty_squares = 0
    self.board.squares.each do |k,v|
      if v == " "
        empty_squares += 1
      end
    end
    empty_squares == 0 ? (return true ): (return false)
  end

  def run
    puts "Welcome to Tic Tac Toe!"
    puts "What's your name?"
    print ">>"
    name = gets.chomp

    user = Player.new(name.capitalize)
    comp = Player.new("Comp")

    begin
      bool_has_winner = false
      bool_board_full = false
      winner = nil
      self.board = Board.new

      acceptable_input = %w( x o )
      input = nil
      system 'clear'
      until acceptable_input.include? input
        puts "Choose to play X or O (X gets to go first!):"
        input = gets.chomp.downcase
      end

      # Set shapes players have chosen.
      input == "x" ? (self.player_x = user; self.player_o = comp) : (self.player_x = comp; self.player_o = user)

      check_for_winner_and_full_board = lambda do
        draw_board()

        find_winner() == nil ? bool_has_winner = false : bool_has_winner = true
        bool_has_winner == true ? (winner = find_winner()) : nil
        is_board_full?() == true ? (bool_board_full = true) : nil
      end

      begin
          draw_board()
        if user == player_x
          user_picks_square(user)
          check_for_winner_and_full_board.call
          bool_has_winner ? break : nil
          bool_board_full ? break : nil

          comp_picks_square(comp)
        else
          comp_picks_square(comp)
          check_for_winner_and_full_board.call
          bool_has_winner ? break : nil
          bool_board_full ? break : nil

          user_picks_square(user)
        end
          check_for_winner_and_full_board.call
          bool_has_winner ? break : nil
          bool_board_full ? break : nil
      end until bool_has_winner or bool_board_full

      if bool_has_winner
        winner == user ? winner_name = user.name : winner_name = comp.name

        puts "#{winner_name} wins!"
      else
        puts "The board is full. It's a tie!"
      end

      puts "Press q to quit. Otherwise, press any key to play again!"
      print ">>"
      input = gets.chomp
      input == "q" ? (bool_user_wants_quit = true) : nil
      bool_has_winner = false
      bool_board_full = false
    end until bool_user_wants_quit == true
  end
end

game = Game.new
game.run
