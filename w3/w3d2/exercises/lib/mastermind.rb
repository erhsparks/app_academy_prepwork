#!/usr/bin/env ruby

# -------------------------------------------------------
# mastermind.rb - Lizzi Sparks - May 2016
#
# A fully playable text-based Mastermind game! Give it
# a try on the command line with '> [path]/mastermind.rb'
#
# Currently, the playable game consists of the user trying
# to guess a randomly-generated code that is between 4 and
# 7 pegs long, with color choices r(ed)-o-y-g-b-p(purple).
# User has ten tries to guess the code, and can type "h"
# for help or "q" to quit at any time. (Quit exits current
# game but `GameWrapper` is still running, so user has the
# choice to play a new game or exit: `"play again? y/n: "`.
#
# Utilizes the `GameWrapper` class located at
# `appacademy-prep/Lizzi_extras/game_wrapper.rb`
# 
#########################################################
# `Code` class: `Code` objects contain the secret code used
# during gameplay (`Game` class).
# Global constants:
# `Code::PEGS` : a hash containing the possible colors for
# `@pegs`. The `keys` are symbols with the color's full name,
# and the `values` are single- character strings of that
# color's first letter, i.e. {`:red =>`"r"`}.
#
# Methods:
# `Code::parse(String)` : `raise`s an error if `String`
# contains illegal values (i.e. something other than one of
# the `values` of `PEGS`). If no error, `::parse` returns a
# new `Code` object whose `@pegs` is an array of each
# character in `String`.
# 
# `Code::random(opt'l Integer)` : returns a new `Code` object
# whose `@pegs` is an array of `Integer` size (or a random
# size between 4 and 7 if no `Integer` specfied), and whose
# values are each randomly chosen from `PEGS`'s `values`.
# 
# `Code#initialize(Array)` : assigns `Array` to `@pegs`,
# 
# `Code#[](Integer)` : shortcut for `Code.pegs[Integer]`.
# 
# `Code#exact_matches(Array or String)` : returns the number
# of exact matches in `Array` or `String` (i.e. the places
# where a "peg" in `@pegs` matches the color and positon
# of the input array/string).
# 
# `Code#near_matches(Array or String)` : returns the number
# of pegs whose colors match `@pegs` but are in different
# indices, i.e. if `@pegs` is `["r", "o", "y", "g"]` and
# input is `"g o r p"`, there would be 1 exact match (the
# "o") and 2 near matches (the "r" and the "g").
# 
# `Code#==(Object)` : returns `true` if Object is a `Code`
# whose `@pegs` is equal to `Code`'s `@pegs`.
# 
#########################################################
# `Game` class: controls gameplay.
# Methods:
# `Game#initialize(opt'l String or Code)` : initializes
# class attribute `@guesses` to `0`. If input is a `Code`
# object, it is assigned to `@secret_code`. If input is
# a `String` (if no input given, input is set to `""`),
# `String` is assigned to class attribute `@name` and
# `@secret_code` is generated randomly (see `Code::random`
# above).
#
# `Game#play` : controls interactive gameplay! This one
# is pretty straightforward to read :)
#
# `Game#welcome_message` : prints a welcome message with
# some basic gameplay instructions (see `#help_message`
# below) and the number of pegs in this game's secret code
# (see `Code::random` above).
#
# `Game#help_message` : prints some basic gameplay
# instructions. Called in `#welcome_message` and `#help`.
#
# `Game#get_guess` : prompts user for a guess. If user
# enters 
#
# `Game#help` : prints a nice ASCII help menu, uses
# `#help_message` above.
#
# `Game#take_turn` : unless `@current_guess` isn't a `Code`
# object (see `#get_guess`), `#take_turn` calls
# `#display_matches(@current_guess)` and then increments
# the `@guesses` counter by `1`. Prompts user for another
# guess with `#get_guess` if `#lost?` and `#quit?` both
# return `false`.
#
# `Game#display_matches(Code)` : prints a message
# informing the user of the number of exact and near
# matches between `@secret_code` and `Code` (==the user's
# current guess during gameplay, see `#take_turn` above).
#
# `Game#won?` : returns `true` if the user's entry
# matches `@secret_code`.
#
# `Game#lost?` : returns `true` if the user has entered
# ten unsuccessful guesses (`@guess` is incremented in
# `#take_turn` above).
#
# `Game#quit?` : returns `true` if the user input `"q"`.
#
# `Game#winning_message` : prints a congratulatoy message.
#
# `Game#losing_message` : prints a message informing user
# he or she has lost, as well as what the secret code was.
#
# -------------------------------------------------------

class Code
  attr_reader :pegs
  PEGS = {
    red:    "r",
    orange: "o",
    yellow: "y",
    green:  "g",
    blue:   "b",
    purple: "p",
  }

  def self.parse(colors)
    colors = colors.downcase.split("")
    raise unless colors.all? { |color| PEGS.values.include?(color) }

    Code.new(colors)
  end

  def self.random(number_of_pegs = nil)
    colors = []

    number_of_pegs = rand(4..7) unless number_of_pegs
    number_of_pegs.times { colors << PEGS.values.sample }

    Code.new(colors)
  end

  def initialize(pegs)
    @pegs = pegs
  end

  def [](index)
    @pegs[index]
  end

  def exact_matches(test_code)
    matches = 0

    @pegs.each_index { |peg| matches += 1 if self[peg] == test_code[peg] }
    
    matches
  end

  def near_matches(test_code)
    near_matches = 0
    color_counts = {secret_code: {}, guessed_code: {}}

    guess_pegs = test_code.pegs
    PEGS.each_value do |color|
      color_counts[:secret_code][color] =
        @pegs.select { |peg| peg == color }.count
      color_counts[:guessed_code][color] =
        guess_pegs.select { |peg| peg == color }.count
    end

    color_counts[:secret_code].each do |color, count|
      if (count > 0) && (color_counts[:guessed_code][color] > 0)
        if count < color_counts[:guessed_code][color]
          near_matches += count
        else
          near_matches += color_counts[:guessed_code][color]
        end
      end
    end

    near_matches - exact_matches(test_code)
  end

  def ==(code)
    code.is_a?(Code) && code.pegs == @pegs
  end
end


class Game
  attr_reader :secret_code, :current_guess, :guesses, :name

  def initialize(user_input = "")
    @guesses = 0

    case user_input
    when String
      @name = user_input
      @secret_code = Code.random
    when Code
      @secret_code = user_input
    else
      raise
    end
  end

  def play
    welcome_message

    get_guess
    take_turn until won? || lost? || quit?

    winning_message if won?
    losing_message if lost?
    puts %(\nUser ended game!) if quit?
  end

  def welcome_message
    print "\nWelcome, #{name}... "
    help_message
    puts "\n**This secret code is #{@secret_code.pegs.count} pegs long**"
  end

  def help_message
    puts %(You have ten tries to guess my secret code!)
    puts %(\nColor choices are:
 "r"ed "o"range "y"ellow "g"reen "b"lue and "p"urple.)
    puts %(\nEnter your guess as i.e. "roygbp" for a six-peg code.)
    puts %(Enter "h" for help or "q" to quit at any time.)
  end

  def get_guess
    puts "\nAttempt \##{@guesses + 1}"
    print "Guess the secret code: "
    guess = gets.chomp

    case guess
    when "h"
      help
      @current_guess = "h"
    when "q"
      @current_guess = "q"
    else
      @current_guess = Code.new(guess.split(""))
    end
  end

  def help
    print %(\n)
    67.times {print "-"}
    print %(\n)

    puts %(Mastermind HELP)
    help_message

    67.times {print "-"}
    print %(\n)
  end

  def take_turn
    if @current_guess.is_a?(Code)
      display_matches(@current_guess)
      @guesses += 1
    end

    get_guess unless lost? || quit?
  end

  def display_matches(code)
    puts %(Found #{@secret_code.exact_matches(code)} exact matches)
    puts %(Found #{@secret_code.near_matches(code)} near matches)
  end

  def won?
    @current_guess == @secret_code
  end

  def lost?
    @guesses == 10
  end

  def quit?
    @current_guess == "q"
  end

  def winning_message
    puts %(\nCongratulations! You guessed the secret code "#{@secret_code.pegs.join("")}" correctly in #{guesses + 1} tries!)
  end
  
  def losing_message
    puts %(\nOh no! Out of guesses, you lose!)
    puts %(My secret code was "#{@secret_code.pegs.join("")}".)
  end
end


########################################################
if __FILE__ == $PROGRAM_NAME
  game_name, game_class = "Mastermind", Game

  require_relative '../../../../Lizzi_extras/game_wrapper.rb'
  GameWrapper.new(game_name, game_class).run
end
########################################################
