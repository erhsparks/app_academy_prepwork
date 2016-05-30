#!/usr/bin/env ruby

# -------------------------------------------------------
# io_exercises.rb - Lizzi Sparks - May 2016
#
# Notes: the guessing game can be played from the command
# line with '> [path]/io_exercises'.
#
# Methods:
# - `guessing_game` : Computer chooses a random number
# between 1 and 100, then prompts the user to guess a number,
# printing out `"too high"` or `"too low"` appropriately
# until user guesses correctly, at which point game prints
# out a congratulatory message which includes the correct
# guess and the number of guesses it took user to get it.
#
# - `shuffle` : prompts the user for a file name, pushes
# each line of corresponding file to an array, shuffles it,
# and prints that array line by line to a new file,
# "{input_name}-shuffled.txt".
#
# -------------------------------------------------------

def guessing_game
  number = rand(1..100)

  guess = -1
  guesses = 0
  until guess == number
    print "Guess a number between 1 and 100: "
    guess = gets.chomp.to_i

    puts "#{guess} is too high" if guess > number
    puts "#{guess} is too low" if guess < number

    guesses += 1
  end

  puts "#{guess} is correct! You guessed #{guesses} times."
end


def shuffle
  print "Enter filename to shuffle: "
  filename = gets.chomp

  file_line_by_line = File.readlines(filename)
  shuffled = file_line_by_line.shuffle

  new_name = ""
  if filename.include?(".")
    new_name = "#{filename.partition(".")[0]}-shuffled.txt"
  else
    new_name = "#{filename}-shuffled.txt"
  end

  File.open(new_name, "w") { |f| shuffled.each { |l| f.puts l } }
end

########################################################
if __FILE__ == $PROGRAM_NAME
  guessing_game
end
########################################################
# Notes: I was playing around with having some options for
# this script like '> io_exercises -g' (i.e.
# `if ARGV(0) == "-g"` for the guessing game and 
# '> io_exercises -s' to shuffle a file entered manually
# (as above) or '> io_exercises -s [file_path/filename]' to
# shuffle a file directly from the command line
# (using `if ARGV(0) == "-s"` and `if ARGV(1)` repectively)
# but ruby gets confused by `gets` when an ARGV is present.
# I'm sure it's a super quick fix but at this point I should
# probably stop tinkering and actually turn all this prepwork!

# So for now, if you want to try out `shuffle`, it works just
# fine from pry if you `require '[path]/io_exercises'`. I've
# included a file named "test.txt" that you can enter when it
# prompts for a filename -- result is saved in
# "text-shuffled.txt" as per specs.
########################################################






# Instructions:


# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
#
#   You could create a random number using the Random class, or you could use the
#   `shuffle` method in array.


# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt".
