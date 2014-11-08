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

  def comp_picks_square
    # Determine what shape the comp is
    comp == player_x ? comp_sym = "X" : comp_sym = "O"

    # Comp randomly picks a square
    comps_choice = %w(1 2 3 4 5 6 7 8 9).sample.to_i until self.board.squares[comps_choice] == " "

    # Comp marks the square
    self.board.squares[comps_choice] = comp_sym
  end

  def user_picks_square
    begin
      puts "Pick a square to mark (1-9):"
      print ">>"
      users_choice = gets.chomp
    end until self.board.squares[users_choice] = " "

    user == player_x ? user_sym = "X" : user_sym = "O"

    self.board.squares[users_choice] = user_sym
  end

  def find_winner
    s = self.board.squares

    if  # Horizontal wins
        (s[1] == s[2] and s[2] == s[3] and s[3] != " ") or
        (s[4] == s[5] and s[5] == s[6] and s[6] != " ") or
        (s[7] == s[8] and s[8] == s[9] and s[9] != " ") or

        # Vertical wins
        (s[1] == s[4] and s)[4] ==s[7] and s[7] != " ") or
        (s[2] == s[5] and s[5] == s[8] and s[8] != " ") or
        (s[3] == s[6] and s[6] == s[9] and s[9] != " ") or

        # Diagonal wins
        (s[1] == s[5] and s[5] == s[9] and s[9] != " ") or
        (s[3] == s[5] and s[5] == s[7] and s[7] != " ")

      # There is a winner, deteminer who it is.
      # If X won, then there will be more X's on the board, since X goes first and will always be ahead one move on his win.
      num_xs = 0
      num_os = 0

      self.board.squares.each do |square|
        square == "X" ? num_xs += 1
        square == "O" ? num_os += 1
      end

      return num_xs > num_os ?  player_x :  player_o

    end

  end

  # TODO: code is_board_full?
  def is_board_full?
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

      # player x goes
      if user == player_x
        # TODO: code player picks square method
        user_picks_square()
        find_winner() == nil ? nil : bool_has_winner = true
        bool_has_winner == true ? (winner = find_winner(); break) : nil
        is_board_full() == true ? (bool_board_full = true; break) : nil
        # XXX:

      else
        comp_picks_square()




      #
      # player y goes
      # check for winner
      # check for full board
      #
    end until bool_has_winner or bool_board_full





  end

end

game = Game.new
game.run
