#!/usr/bin/env ruby

# -------------------------------------------------------
# player.rb - Lizzi Sparks - May 2016
#
# Part of the w3d3 Battleships game. See './battleship.rb'
# for more details.
#
# `HumanPlayer` class: handles human-game interactions.
# Methods:
# - `HumanPlayer#initialize(opt'l String)` : if `String`
# is specified, it is assigned to class attribute `@name`.
#
# - `HumanPlayer#get_play` : prompts user for a move,
# checking whether input is valid (see `#legal_move?) and
# re-prompting (see `#retry_entry`) until a valid input
# is recieved. Returns an array containing two integers,
# `[row, column]` for `BattleshipGame` class to parse, or
# a single string "q" if user wants to quit game.
#
# - `HumanPlayer#retry_entry` : re-informs user how moves
# should be entered & re-prompts (calls `#get_play` above).
#
# - `HumanPlayer#legal_entry?(String)` : returns `true` only
# if `String` contains only `"q"` or two numbers separated by
# a comma (see: `#exactly_two?()` and `#all_numbers?()` below).
# Extra whitespace (i.e. `"  1 , 1 "` vs `"1,1"`) is ignored.
#
# - `HumanPlayer#exactly_two?(String)` : returns `true` only
# if `String` has exactly two entries separated by a comma.
#
# - `HumanPlayer#all_numbers?(String)` : returns `true`
# if each substring between `","` contains only numbers.
# N.B. user could enter an illegal-ish entry as `"1 2, 3 4"`,
# which would satisfy this and `#non_number` below but is
# obviously wrong -- however, when `#get_play` calls
# `#to_i` on each of `"1 2"` and `"3 4", it'll recieve `1`
# and `3`, which are a perfectly ok set of coords to send.
# User might be confused, but maybe it'll teach user to read
# the directions ;)
#
# - `HumanPlayer#non_number?(String)` : `#to_i` will return
# `0` for any string whose first non-whitespace character
# is not an integer, but since `0` is also a valid coordinate,
# `#non_number?` checks whether `String` (with start & end
# whitespace stripped) is actually `"0"`. Returns `true` if
# it is not.
# 
# -------------------------------------------------------

class HumanPlayer
  attr_reader :name

  def initialize(name = nil)
    @name = name if name
  end

  def get_play
    print "Enter attack coordinates: "
    pos = gets.chomp

    pos = retry_entry until legal_entry?(pos)

    if pos == "q"
      pos
    else
      pos.split(",").map &:to_i
    end
  end

  def retry_entry
    puts %(\nWarning! Print attack coordinates in the form "row, column")
    get_play
  end

  def legal_entry?(pos)
    pos == "q" || (exactly_two?(pos) && all_numbers?(pos))
  end

  def exactly_two?(pos)
    pos.split(",").length == 2
  end

  def all_numbers?(pos)
    pos.split(",").none? { |char| non_number?(char) }
  end

  def non_number?(char)
    char.to_i == 0 && char.strip != "0"
  end
end
