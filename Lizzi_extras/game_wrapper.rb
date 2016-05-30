#!/usr/bin/env ruby

# -------------------------------------------------------
# game_wrapper.rb - Lizzi Sparks - May 2016
# 
# `GameWrapper` class:
# - displays a standard welcome, "play again?", and goodbye
# message for a game, as well as playing the game passed.
# Attributes:
# - `@game_name` and `@game_class`: passed in in `#initialize`.
# - `@player_name`: set during `GameWrapper#welcome_message`.
# 
# Methods:
# - `#welcome_message`: prints a welcome message, asks
# for player's name, sets `@player_name` for game's use.
# - `#run`: displays welcome message, calls play, displays
# goodbye message after play had finished.
# - `#play`: creates a new `*GameClass` object, runs
# `*GameClass#play` until `#play_again?` returns `false`.
# - `#play_again?`: asks players if they would like to
# play again and returns `true`/`false`.
# - `#goodbye_message`: prints a goodbye message.
#
# Notes: at some point, I want to make a game_center.rb which
# contains a wrapper similar to this one and lets the user
# choose which game they'd like to play from within the program.
# So you'd be able to play, say, Mastermind, then Hangman,
# then Battleships, over and over in whichever order you'd
# like, without exiting the program. It shouldn't take too
# much more work than I've already done but I should really
# stop being distracted and actually turn this prepwork in first!
#
# -------------------------------------------------------

class GameWrapper
  attr_reader :game_name, :game_class, :player_name, :display_width

  def initialize(game_name, game_class)
    @game_name = game_name
    @game_class = game_class
    @display_width = 67       # arbitary but looks good on my terminal
  end

  def welcome_message
    @display_width.times { print "-" }
    print "\n"
    puts "Welcome to #{@game_name}!".center(@display_width)
    print "\nEnter your name: "
    @player_name = gets.chomp.capitalize
  end

  def run
    welcome_message

    play
    play while play_again?

    goodbye_message
  end

  def play
    game = game_class.new(@player_name)

    game.play
  end

  def play_again?
    print "\nWould you like to play again? (y/n): "
    answer = gets.chomp

    case answer
    when "y" then true
    when "n" then false
    else
      puts "\nInvalid response!"
      play_again?
    end
  end
  
  def goodbye_message
    puts "\n"
    puts "Goodbye!".center(@display_width)
    @display_width.times { print "-" }
    puts "\n"
  end
end
