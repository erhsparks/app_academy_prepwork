#!/usr/bin/env ruby

# -------------------------------------------------------
# board.rb - Lizzi Sparks - May 2016
#
# Part of the w2d4 Tic-Tac-Toe game
#
# `Board` class:
# Methods:
# - `Board#initialize(optional Array)` : `Array` should be
# an array of arrays, representing a grid. `Array` is
# assigned to `Board#grid`. If no array specified, default
# `@grid` is the standard 3x3 array, populated with `nil`s.
#
# - `Board#[](Integer1, Integer2)` : a helper method to
# make calling `Board.grid[row][col]` less cumbersome as
# `Board[row,col]` (syntactic sugar for `Board.[](row, col)`
# above.
#
# - `Board#[]=(Integer1, Integer2, Symbol)` : as `#[](...)`
# above -- turns `Board.grid[row][col] = sym` into
# much nicer `Board[row, col] = sym`.
#
# - `Board#place_mark(Array, Symbol)` : assigns `@grid`
# at position specified by `Array` to `Symbol`.
#
# - `Board#empty?(Array)` : returns `true` if `@grid` in
# position specified in `Array` has a value of `nil`.
#
# - `Board#winner` : returns `:X` if the player using Xes
# has won, or `:O` if Os has won, else returns `nil`
# if no winning combinations found.
#
# - `Board#over?` : returns `true` if either player has
# won (see `Board#winner` above) or if the board is full.
# 
# -------------------------------------------------------

class Board
  attr_reader :grid

  def initialize(grid = Array.new(3) { Array.new(3) })
    @grid = grid
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def place_mark(pos, mark)
    self[*pos] = mark if self.empty?(pos)
  end

  def empty?(pos)
    self[*pos].nil?
  end

  def winner
    win_X = [:X, :X, :X]
    win_O = [:O, :O, :O]

    possible_wins = {
      row0: @grid[0],
      row1: @grid[1],
      row2: @grid[2],

      col0: [ self[0,0], self[1,0], self[2,0] ],
      col1: [ self[0,1], self[1,1], self[2,1] ],
      col2: [ self[0,2], self[1,2], self[2,2] ],

      diag_l: [ self[0,0], self[1,1], self[2,2] ],
      diag_r: [ self[2,0], self[1,1], self[0,2] ]
    }

    possible_wins.each_value do |value|
      case value
      when win_X then return :X
      when win_O then return :O
      end
    end

    nil
  end

  def over?
    winner || @grid.none? { |row| row.include?(nil) }
    # "Negative, Ghostrider. The pattern is full."
  end
end
