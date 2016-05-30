#!/usr/bin/env ruby

# -------------------------------------------------------
# game.rb - Lizzi Sparks - May 2016
#
# Part of the w2d4 Tic-Tac-Toe game
# Bare bones version of Tic-Tac-Toe w no 
#
# "Greetings, Professor Falken..."
#
# `Game` class:
# Methods:
# - `Game#initialize(player1, player2)` : `players 1` and
# `2` are either of class `HumanPlayer` or `ComputerPlayer`.
# Assigns first to `@player_one` and second to `@player_two`,
# as well as assiging `@board` a new `Board` object and
# `@current_player` to `@player_one`.
#
# - `Game#play` : calls `#play_turn` until `@board.over?`
# returns `true`.
#
# - `Game#play_turn` : sends `@board` to `@current_player`
# (see `*Player#display(Board)`) and receives position array
# (see `*Player#get_move`). Marks `@board`
# (see `Board#place_mark(...)`) and sends this updated
# `@board` back to `@current_player` before ending that
# player's turn (see `#switch_players!` below).
#
# - `Game#switch_players!` : reassigns `@current_player`
# to whichever of `@player_one` or `@player_two` is not
# currently assigned there.
# 
# -------------------------------------------------------

require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :player_one, :player_two, :board, :current_player

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Board.new
    @current_player = @player_one
  end

  def play
    play_turn until @board.over?
  end

  def play_turn
    @current_player.display(@board)
    pos = @current_player.get_move

    @board.place_mark(pos, @current_player.mark)

    @current_player.display(@board)

    switch_players!
  end

  def switch_players!
    if @current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end
end
