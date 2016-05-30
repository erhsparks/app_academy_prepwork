#!/usr/bin/env ruby

# -------------------------------------------------------
# hangman.rb - Lizzi Sparks - May 2016
#
# A fully playable text-based Hangman game! Give it
# a try on the command line with '> [path]/hangman.rb'
#
# Utilizes the `GameWrapper` class located at
# `appacademy-prep/Lizzi_extras/game_wrapper.rb`
#
# Interactive gameplay starts with a prompt to the user to
# choose whether he or she would like to c(hoose word for 
# computer to guess) or g(uess computer's word). 
#
# Players are given ten lives, represented by a row of '*'s
# --I briefly considered having the game print out each stage
# of a little ASCII dude being hanged when the guesser guesses
# incorrectly but... that's pretty grim. Definitely did not
# notice how grisly this game was when I was a kid!
#
# 
#########################################################
# `Hangman` class: controls gameplay.
# Methods:
# `Hangman#initialize(options hash or String)` : if input
# is an options hash with keys `:guesser` and `:referee`,
# the values of each are set to class attributes `@guesser`
# and `@referee`, repectively. If input is `String`, it is
# assumed to be the human player's name and is sent as an
# argument to `#choose_players(String)`, which returns an
# options hash with the player's choice of referee and
# guesser. Class attribute `@chances_left` is initialized
# to an array of ten `"*"` entries, representing the
# guesser's guesses left before game over.
#
# `Hangman#choose_players(String)` : calls `#user_chooses`
# to prompt user to choose whether he or she wants to be
# the guesser or the referee for the current game. Returns
# an options hash with `keys` `:guesser` and `:referee`
# and corresponding `values` `HumanPlayer.new(String)` and
# `ComputerPlayer.new` assigned according to user's choice.
#
# N.B. `HumanPlayer`'s and `ComputerPlayer`'s main methods
# (`ComputerPlayer` has one additional helper method,
# `ComputerPlayer#default_dicitonary`) are interchangeable,
# so the various `Hangman` methods discussed below are able
# to call `@guesser.[method]` and `@referee.[method]`
# indiscrimnately on either type of object, and will be
# referred to as such for the rest of this section, rather
# than `Class#method`.
# 
# `Hangman#user_chooses` : returns either `"c"` or `"g"`
# for "chooser" (referee) or guesser. If user enters
# anything other than "c" or "g", prints an error and re-
# prompts until "c" or "g" is recieved.
# 
# `Hangman#play` : controls gameplay. Calls `#setup` and
# then `#take_turn` repeatedly until `@guesser` has won
# or lost, then displays the appropriate winning or losing
# message. See helper methods `#won?`, `#lost?`,
# `#winning_message`, and `#losing_message` below.
# 
# `Hangman#setup` : prompts the referee for the size of
# the word to be guessed (the "secret word") and assigns
# `@board` a new array of that length, populated with "_"s.
# Lets the guesser know how long the secret word is, and
# calls `#display_board` when run as an interactive game
# from the command line.
# 
# `Hangman#take_turn` : asks guesser for a guess (a single
# letter), sends that guess to referee to find out whether
# or not letter is in their secret word and where, if so.
# If letter is in the secret word, updates board accordingly,
# else takes one `"*"` off the `@chances_left` array. Lets
# guesser handle response (`ComputerPlayer` narrows down its
# dicitonary, `HumanPlayer` does nothing -- see note under
# `HumanPlayer#handle_response`). Displays board if
# interactive game session.
#
# `Hangman#update_board(String, Array)` : assigns `String`
# (which should be a single letter character) to each index
# of `@board` listed in `Array` (an array of integers
# between `0` and length of secret word).
#
# `Hangman#won?` : returns `true` if all letters in `@board`
# have been filled in with letters, i.e. does not have any
# `"_"` characters left.
#
# `Hangman#lost?` : returns `true` if 0 guesses left OR if
# the computer is the guesser and has run out of words to
# guess (i.e. user's word is not in computer's dictionary).
#
# `Hangman#display_board` : prints board (as a joined string),
# rejected letters guesses, and number of guesses left.
#
# `Hangman#winning_message` : prints a message congratulating
# user if user was the guesser, or a nice "good game!"
# message if computer was the guesser.
# 
# `Hangman#losing_message` : oh no! In this world, people
# who can't guess a word in ten tries or fewer get hanged!
# Prints a losing message poking fun at how gruesome this
# game is, slightly different depending on who was guesser,
# user or computer.
#
#########################################################
# `ComputerPlayer` class: controls computer responses.
# Methods:
# `ComputerPlayer#initialize(opt'l Array)` : if `Array`
# specified, it is assigned to class attribute `@dictionary`,
# if not, the default dictionary is assigned (see
# `#default_dictionary` below). Assigns `@dictionary` to
# class attribute `@candidate_words` (words that will be
# narrowed down as letter choices are accepted or rejected
# by the referee). Assigns an empty array to class attribute
# `@rejected`, which will hold letters rejected by referee.
# 
# `ComputerPlayer#default_dictionary` : parses the file
# 'dictionary.txt' (located in this directory) line by line
# into an array. Returns this array with any leading or
# trailing whitespace stripped off.
# 
# `ComputerPlayer#pick_secret_word` : assigns a random word
# from `@dictionary` to class attribute `@secret_word` and
# returns the length of that word.
# 
# `ComputerPlayer#check_guess(String)` : returns an array
# containing the indices of the secret word where `String`
# appears. Returns an empty array if `String` is not in
# `@secret_word`).
# 
# `ComputerPlayer#register_secret_length(Integer)` : narrows
# down candidate word choices to only those whose length is
# `Integer`.
# 
# `ComputerPlayer#guess(Array)` : returns a single-character
# string containing the letter that appears most frequently
# in `@candidate_words`.
# 
# `ComputerPlayer#handle_response(String, Array)` : 
# narrows down computer's list of candidate words by
# removing any words with more occurrances of `String`
# -- or occurrences in different locations -- than is
# indicated in `Array` (an array of integers representing
# indices in the referee's secret word where `String` is
# found).
#
#########################################################
# `HumanPlayer` class: controls human user actions.
# Methods:
# `HumanPlayer#initialize(opt'l String)` : 
# 
# `HumanPlayer#pick_secret_word` : prompts user for the
# number of letters in their secret word (and continues to
# re-prompt if user enters something invalid); returns that
# number.
# 
# `HumanPlayer#check_guess(String)` : prints computer's
# guess (`String`) to the screen and, using helper method
# `#ask_user()` below, returns an array containing the
# indices where that letter appears in the user's secret
# word (it is empty if the guessed letter does not appear).
# 
# `HumanPlayer#ask_user(String)` : prompts user for the
# number of times `String` appears in the secret word. Re-
# prompts if invalid entry until a valid entry is input.
# I assumed for gameplay that your typical user is not
# used to 0-indexed strings and would consider the first
# letter of the word to be position 1. This is taken into
# account in method `#check_guess()` above.
# 
# `HumanPlayer#register_secret_length(Integer)` : prints a
# message letting user know length computer's secret word.
# 
# `HumanPlayer#guess(Array)` : prompts user for a guess;
# returns guess if it is a single letter or reprompts
# if not (i.e. user's guess was 0 or more than 1 letters)
# or if user guesses a previously guessed letter.
# 
# `HumanPlayer#handle_response(String, Array)` : an empty
# method. It exists purely here to let the specs pass. My
# here is that `ComputerPlayer#handle_response` exists to
# help the computer make educated guesses by narrowing down
# its list of candidate words, but a human does that work in
# his or her head, so the program should do nothing. If there
# were no specs to satisfy, the `@guesser.handle_response()`
# line in `Hangman#take_turn` would include the logic:
# `if @guesser.is_a?(ComputerPlayer)`.
#
# -------------------------------------------------------

class Hangman
  attr_reader :guesser, :referee, :board, :chances_left, :name

  def initialize(players)
    players = choose_players(players) if players.is_a?(String)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @chances_left = Array.new(10, "*")
  end

  def choose_players(name)
    players = {}

    user_choice = user_chooses
    case user_choice
    when "c"
      players[:referee] = HumanPlayer.new(name)
      players[:guesser] = ComputerPlayer.new
    when "g"
      players[:referee] = ComputerPlayer.new
      players[:guesser] = HumanPlayer.new(name)
    end

    players
  end

  def user_chooses
    puts %(
Would you like to...
  "c"hoose a word for the computer to guess?
  "g"uess the computer's word?)
    print %(Enter "c" or "g" now: )
    user_choice = gets.chomp

    unless user_choice == "c" || user_choice == "g"
      puts "
Invalid choice!"
      user_choice = user_chooses
    end

    user_choice
  end

  def play
    setup

    take_turn until won? || lost?

    winning_message if won?
    losing_message if lost?
  end

  def setup
    @board = Array.new(@referee.pick_secret_word,"_")
    @guesser.register_secret_length(@board.length)
    display_board if __FILE__ == $PROGRAM_NAME # i.e. not when specs execute
  end

  def take_turn
    guess = @guesser.guess(@board)
    indices = @referee.check_guess(guess)

    if indices.empty?
      @chances_left.pop 
    else
      update_board(guess, indices)
    end

    @guesser.handle_response(guess, indices)
    # see note under `HumanPlayer#handle_response`

    display_board if __FILE__ == $PROGRAM_NAME
  end

  def update_board(guess, indices)
    indices.each { |i| @board[i] = guess }
  end

  def won?
    !board.include?("_")
  end

  def lost?
    @chances_left.empty? ||
      (@guesser.is_a?(ComputerPlayer) && @guesser.candidate_words.empty?)
  end

  def display_board
    puts "
#{board.join(" ")}
Rejected letters: #{@referee.rejected.sort.join(" ")}
Chances to escape left: #{@chances_left.join(" ")}"
  end

  def winning_message
    case @guesser
    when HumanPlayer then puts "
Congratulations, you discovered my secret word!"
    when ComputerPlayer then puts "
Awesome, I discovered your secret word! Good game, #{@referee.name}!"
    end
  end

  def losing_message
    case @guesser
    when HumanPlayer then puts %(
Oh no, you were GRUESOMELY HANGED!

My word was "#{@referee.secret_word}")
    when ComputerPlayer then puts "
Computer was UNABLE TO GUESS your secret word and was HANGED UNTIL DEAD...

Good game, #{@referee.name}!"
    end
  end
end


########################################################
class ComputerPlayer
  attr_reader :dictionary, :candidate_words, :rejected, :secret_word

  def initialize(dictionary = default_dictionary)
    @dictionary = dictionary
    @candidate_words = @dictionary
    @rejected = []
  end

  def default_dictionary
    filename = File.expand_path("../dictionary.txt", __FILE__)
    dictionary = File.readlines(filename)
    dictionary.each &:strip!
  end

  def pick_secret_word
    @secret_word = dictionary.sample
    @secret_word.length
  end

  def check_guess(letter)
    indices = []
    if @secret_word.include?(letter)
      @secret_word.length.times { |i| indices << i if @secret_word[i] == letter }
    else
      @rejected << letter unless @rejected.include?(letter)
    end

    indices
  end

  def register_secret_length(board_length)
    @candidate_words.select! { |word| word.length == board_length }
  end

  def guess(board)
    guess = ""
    guess_count = 0

    letters = @candidate_words.join("").split("")
    letters.delete_if { |letter| board.include?(letter) }
    letters = letters.sort.join("")

    letters.each_char do |letter|
      current_count = letters.scan(letter).length
      if current_count > guess_count
        guess_count = current_count
        guess = letter
      end
    end

    guess
  end

  def handle_response(letter, indices)
    @candidate_words.select! do |word|
      (word.scan(letter).length == indices.length) &&
        (indices.all? { |index| word[index] == letter })
    end
  end
end


########################################################
class HumanPlayer
  attr_reader :name, :rejected, :board_length

  def initialize(name = "")
    case name
    when "" then @name = "No Name"
    else @name = name
    end

    @rejected = []
  end

  def pick_secret_word
    print "
Think of a secret word...
Enter the number of letters in your secret word: "

    secret_word_length = gets.chomp.to_i
    if secret_word_length < 1
      puts "
Invalid length!"
      secret_word_length = pick_secret_word
    end

    @board_length = secret_word_length
  end

  def check_guess(letter)
    puts "
Computer guessed: #{letter}"
    print %(
Enter the letter position(s) where "#{letter}" appears in your secret word...
  Enter "0" if #{letter} does not appear in your secret word.
  Separate letter positions with commas if "#{letter}" appears more than once.
Enter letter position(s) now: )

    indices = ask_user(letter)
    case indices
    when [0]
      @rejected << letter unless @rejected.include?(letter)
      puts "
Ok, I'll try again!"

      []
    else
      indices.map { |index| index - 1 }
      # the (- 1) above is bc player will enter i.e. "1,4" for "t" in "test"
      # i.e. gameplay assumes player is used to 1-indexed words, not 0-indexed
    end
  end

  def ask_user(letter)
    indices = gets.chomp.split(",")

    if indices.map(&:to_i).include?(0) && indices != ["0"]
      print %(
Invalid entry! Enter only:
 a single number if "#{letter}" appears once,
 multiple numbers separated with commas if more than once,
 a single 0 if "#{letter}" is not in your secret word.

Re-enter positions where "#{letter}" appears now: )

      ask_user(letter)
    elsif indices.map(&:to_i).any? { |i| i > @board_length }
      print %(
Invalid entry! You entered a number that was greater than the length of your word!

Re-enter positions where "#{letter}" appears now: )

      ask_user(letter)
    else
      indices.map &:to_i
    end
  end

  def register_secret_length(board_length)
    puts "
My word is #{board_length} letters long."
  end

  def guess(board)
    print "
Guess a letter: "
    letter = gets.chomp

    if letter.length == 0
      guess(board)
    elsif letter.length > 1
      puts "
Invalid entry! Enter only one letter."

      guess(board)
    elsif board.include?(letter) || @rejected.include?(letter)
      puts %(
You've already guessed "#{letter}"!)

      guess(board)
    else
      letter
    end
  end

  def handle_response(guess, indices); end
end


########################################################
if __FILE__ == $PROGRAM_NAME
  game_name, game_class = "Hangman", Hangman

  require_relative '../../../../Lizzi_extras/game_wrapper.rb'
  GameWrapper.new(game_name, game_class).run
end
########################################################
# Note: ComputerPlayer#guess -- 1st guess noticeably slower for longer words.

# Note: Chould implement a choice of "easy"/"medium"/"hard" for when the
# computer is referee, broken down i.e. (1-5 words)/(5-9 words)/(10+ words).

# Note: an undo and/or way to stop current game if mistaken entry would be cool.
# I couldn't think of a good "quit" string -- obviously can't be "q"! -- but see
# w3d2 Mastermind for a game with some "quit current instance of game" logic.
