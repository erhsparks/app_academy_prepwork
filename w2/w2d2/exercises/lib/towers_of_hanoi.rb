#!/usr/bin/env ruby

# -------------------------------------------------------
# towers_of_hanoi.rb - Lizzi Sparks - May 2016
#
# V bare bones version of Towers of Hanoi game
#
# `TowersOfHanoi` class:
# Methods:
# - `TowersOfHanoi#initialize` : creates our game board,
# `@towers`, an array of three arrays representing each
# of the three eponymous towers. Our game has three discs,
# represented by the integers `1`, `2`, and `3`, `3` being
# the largest disc and `1` the smallest. They are initialized
# to a stack on the first tower (`@towers[0]`).
#
# - `TowersOfHanoi#move(Index1, Index2)` : moves top disc
# on tower at `Index1` to tower at `Index2` if that move
# is allowed (see helper method `#valid_move?(...)`).
#
# - `TowersOfHanoi#valid_move?(Index1, Index2)` : returns
# `true` only if the top disc on `Index1` is smaller than
# the top disc on `Index2`.
#
# - `TowersOfHanoi#won?` : return `true` if all three
# discs have been moved from the first tower to either of
# the other two.
# 
# -------------------------------------------------------

class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers = [ [3, 2, 1], [ ], [ ] ]
  end

  def move(from, to)
    @towers[to] << @towers[from].pop if valid_move?(from, to)
  end

  def valid_move?(from, to)
    return true if @towers[to].empty?
    return false if @towers[from].empty?
    return false if @towers[from].last > @towers[to].last
    true
  end

  def won?
    @towers[1..2].any? { |tower| tower.size == 3}
  end
end




# Instructions:

# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp/) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.
