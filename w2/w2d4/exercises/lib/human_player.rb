#!/usr/bin/env ruby

# -------------------------------------------------------
# human_player.rb - Lizzi Sparks - May 2016
#
# Part of the w2d4 Tic-Tac-Toe game
#
# `HumanPlayer` class:
# Methods:
# -  `HumanPlayer#initialize(String)` : saves `String` to
# class attribute `@name`.
#
# -  `HumanPlayer#get_move` : prompts user for input in
# the form `'row, column'`. Returns an index containing
# two integers corresponding to the two inputs. Obv in a
# real game, there'd be preventative code to check for
# illegal inputs here.
#
# -  `HumanPlayer#display(Board)` : prints the board in
# its current state of play, saved in `Board.grid`, to the
# terminal.
# 
# -------------------------------------------------------

class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_move
    puts "Where would you like to place your move?"
    print "Enter as 'row, column': "

    pos = gets.chomp.split(",").map &:to_i
  end

  def display(board)
    print board.grid
  end
end
