#!/usr/bin/env ruby

# -------------------------------------------------------
# battleship.rb - Lizzi Sparks - May 2016
#
# A fully playable text-based Battleships game! Give it
# a try on the command line with '> [path]/battleship.rb'
#
# Utilizes the `GameWrapper` class located at
# `appacademy-prep/Lizzi_extras/game_wrapper.rb`
#
# Currently gameplay consists of a single human player
# firing at the computer's board, which has been randomly
# populated with the five canonical ships from the original
# game (see `Board::SHIPS`), with a nice ASCII UI :)
#
# `BattleshipGame` class: controls gameplay.
# Methods:
# `BattleshipGame#initialize(opt'l String or HumanPlayer,
# opt'l Board)` : if first optional input is a string, it's
# assumed to be the player's name (and if player just hit
# enter when prompted for a name, `player` is set to `"No Name"`)
# and class attribute `@player` is set to a new `HumanPlayer`
# object with the name `player`. If player is a `HumanPlayer`
# object, it is assigned to `@player`. `Board` (or a new `Board`
# object if one not given) is assigned to class attribute
# `@board`. Class attribute `@quit_game`, used to check if the
# user has asked to end play, is initialized to `false`.
#
# `BattleshipGame#play` : adds ships to the board by calling
# `Board#populate_grid` and then loops continously through calls
# to display the grid to the user and have the user take a turn
# until they have either won or asked to quit (see `#game_over?`).
# If the user has won, method displays the grid one final time,
# if user quit, skips this step. Prints out the appropriate
# goodbye message for either end scenario.
#
# `BattleshipGame#intro_message` : prints an intro message
# with some basic gameplay instructions.
#
# `BattleshipGame#game_over?` : returns `true` if user has
# entered `"q"` (`@quit_game == true`) or if user has
# hit all ships on the board (see `Board#won?`).
#
# `BattleshipGame#display_grid` : prints an ASCII grid with
# blank spaces for uncharted sea, `"X"` for hit ships, and
# `"~"` for empty ocean (i.e. where a fired shot did not hit
# an enemy ships). See: `Board#grid_player_sees` and
# `Board#display()`.
#
# `BattleshipGame#count` : returns number of ships left on
# the board by calling `Board#count`.
#
# `BattleshipGame#play_turn` : Gets input from the user (see
# `#get_play` below) and either: quits the current instance
# of the game if user entered `"q"`, re-prompts the user if
# they entered coordinates out of the map range (i.e. `"11,40"`),
# or attacks that position on the board with `#attack(position)`
#
# `BattleshipGame#get_play` : returns result of call to
# `HumanPlayer#get_play`.
#
# `BattleshipGame#attack(Array)` : sets class attribute
# `@current_attack` to `Array` and checks whether the attack is:
# - a repeat attack : prints a message informing the user that
# they've already attacked that space.
# - a hit : prints a message informing user that they scored
# a direct hit. If they hit the last part of a given ship, also
# prints out i.e. "You sank the enemy's Battleship!". Updates
# `Board#grid` and `Board.grid_player_sees` accordingly.
# - a miss : prints a "you missed!" message to user and updates
# `Board#grid` and `Board.grid_player_sees` accordingly.
#
# `BattleshipGame#repeat_attack?` : returns `true` if the board
# has an `:x` at `@current_attack`.
#
# `BattleshipGame#register_repeat` : prints a message informing
# the user that they've already attacked that space.
#
# `BattleshipGame#hit?` : returns `true` if the board contains
# one of the ship symbols (see `Board::SHIPS`) at `@current_attack`.
#
# `BattleshipGame#register_hit` : prints a message informing user
# that they scored a direct hit. If they hit the last part of a
# given ship, also prints out i.e. "You sank the enemy's
# Battleship!". Updates `Board#grid` and `Board.grid_player_sees`.
#
# `BattleshipGame#ship_sunk?(Symbol)` : returns `true` when player
# has hit the last part of a given ship, i.e. if board has only one
# of `Symbol` left (1 not 0 because this method is called by
# `#register_hit` BEFORE it updates the board).
#
# `BattleshipGame#ship_sunk_message(Symbol)` : prints a message
# informing user that they sank an entire enemy ship, after
# sending `Symbol` to `Board#ship_type()` to learn the ship's name.
# 
# `BattleshipGame#miss?` : returns `true` if the board contains
# `nil` at `@current_attack`.
#
# `BattleshipGame#register_miss` : prints a "you missed!" message
# to user and updates `Board#grid` and `Board.grid_player_sees`.
#
# `BattleshipGame#game_over_message` : prints a goodbye message.
#
#########################################################
# See also:
# board.rb for `Board` class.
# player.rb for `HumanPlayer` class.
# 
# -------------------------------------------------------

class BattleshipGame
  attr_reader :board, :player, :current_attack

  def initialize(player = HumanPlayer.new, board = Board.new)
    if player.is_a?(String)
      player = "No Name" if player == ""

      @player = HumanPlayer.new(player)
    else
      @player = player
    end

    @board = board
    @quit_game = false
  end
  
  def play
    @board.populate_grid
    intro_message

    until game_over?
      display_grid
      play_turn
    end
    
    display_grid unless @quit_game
    game_over_message
  end

  def intro_message
    print %(
Welcome, Commander #{player.name}... Enemy ships have been detected nearby!

Commander, we desperately need YOUR help to find and destroy them
before it's too late!

Enter the coordinates of suspected enemy warships in the form "0,0"
(row, column) and I'll send a missile to "explore" the region.

[You may enter "q" at any time to end current game]\n\n)
  end

  def game_over?
    @quit_game || @board.won?
  end
  
  def display_grid
    @board.display(@board.grid_player_sees)
  end    

  def count
    @board.count
  end

  def play_turn
    print "\n"
    pos = get_play
    print "\n"

    if pos == "q"
      @quit_game = true
    elsif @board.in_range?(pos)
      attack(pos)
      print "\n"
    else
      puts "Coordinates out of map range, Commander! Try again..."
      get_play
    end
  end
  
  def get_play
    @player.get_play
  end
  
  def attack(pos)
    @current_attack = pos

    if repeat_attack?
      register_repeat
    elsif hit?
      register_hit
    elsif miss?
      register_miss
    end
  end
  
  def repeat_attack?
    @board[current_attack] == :x
  end
  
  def register_repeat
    print "You've already attacked that position...\n\n"
  end
  
  def hit?
    Board::SYMBOLS.include?(@board[current_attack])
  end
  
  def register_hit
    print "Direct hit!"
    
    ship_sym = @board[current_attack]
    ship_sunk_message(ship_sym) if ship_sunk?(ship_sym)

    print "\n\n"
    
    @board.mark_display_grid(current_attack, :X)
    @board[current_attack] = :x
  end
  
  def ship_sunk?(ship_sym)
    @board.count(ship_sym) == 1
  end
  
  def ship_sunk_message(ship_sym)
    ship_type = @board.ship_type(ship_sym)
    
    print " You sank the enemy's #{ship_type}!"
  end
  
  def miss?
    @board[current_attack].nil?
  end
  
  def register_miss
    print "Splash! You missed!\n\n"

    @board.mark_display_grid(current_attack, :~)
    @board[current_attack] = :x
  end

  def game_over_message
    if @quit_game
      puts "\nUser ended game!\n"
    else
      puts "\nCongratulations! You sank all the enemy's ships!\n"
    end
  end
end

########################################################
if __FILE__ == $PROGRAM_NAME
  require_relative 'player.rb'
  require_relative 'board.rb'

  game_name, game_class = "Battleship", BattleshipGame

  require_relative '../../../../Lizzi_extras/game_wrapper.rb'
  GameWrapper.new(game_name, game_class).run
end
########################################################
