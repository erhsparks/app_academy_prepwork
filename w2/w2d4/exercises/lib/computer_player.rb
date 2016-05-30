#!/usr/bin/env ruby

# -------------------------------------------------------
# computer_player.rb - Lizzi Sparks - May 2016
#
# Part of the w2d4 Tic-Tac-Toe game
#
# `ComputerPlayer` class:
# Methods:
# - `ComputerPlayer#initialize(String, opt'l Symbol)` :
# assigns `String` to class attribute `@name` and `Symbol`
# to `@mark`. If `Symbol` not specified, `@mark` given `:O`.
#
# - `ComputerPlayer#display(Board)` : assigns `Board` to
# class attribute `@board`.
#
# - `ComputerPlayer#get_move` : returns a winning move if
# one is available (see `#winning_move below), or a random
# position on the board if not.
#
# - `ComputerPlayer#winning_move` : returns an array of
# size 2 containing the row, column of a winning move, if
# any exists. If no winning move found, returns `nil`.
# 
# -------------------------------------------------------

class ComputerPlayer
  attr_reader :name, :board
  attr_accessor :mark

  def initialize(name, mark = :O)
    @name = name
    @mark = mark
  end

  def display(board)
    @board = board
  end

  def get_move
    if winning_move
      pos = winning_move
    else
      test_pos = [rand(0..2), rand(0..2)] 
      test_pos = [rand(0..2), rand(0..2)] until @board[*test_pos].nil?
      pos = test_pos
    end
  end

  def winning_move
    almost0 = [nil, @mark, @mark]
    almost1 = [@mark, nil, @mark]
    almost2 = [@mark, @mark, nil]

    positions = {
      row_0: [ [0,0], [0,1], [0,2] ],
      row_1: [ [1,0], [1,1], [1,2] ],
      row_2: [ [2,0], [2,1], [2,2] ],

      col_0: [ [0,0], [1,0], [2,0] ],
      col_1: [ [0,1], [1,1], [2,1] ],
      col_2: [ [0,2], [1,2], [2,2] ],

      diag_l: [ [0,0], [1,1], [2,2] ],
      diag_r: [ [2,0], [1,1], [0,2] ]
    }

    winner = []
    positions.each do |test_line, value|
      v0, v1, v2 = value

      case [ @board[*v0], @board[*v1], @board[*v2] ]
      when almost0 then winner << v0
      when almost1 then winner << v1
      when almost2 then winner << v2
      end
    end

    winner.first
  end
end
