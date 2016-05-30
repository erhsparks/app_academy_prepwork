#!/usr/bin/env ruby

# -------------------------------------------------------
# 03_simon_says.rb - Lizzi Sparks - May 2016
#
# Methods:
# - `echo(String)` : returns the input string.
#
# - `shout(String)` : returns input string in uppercase.
#
# - `repeat(String, Integer)` : returns a string with the
# input string repeated integer times, separated by spaces.
#
# - `start_of_word(String, Integer)` : returns a string matching
# the first `Integer` number of characters in `String`.
# i.e. `start_of_word("doggy", 3)` returns `"dog"`.
#
# - `first_word(String)` : returns a string, the first "word"
# in the input string -- i.e. the string of characters
# between the first non-space character and the next space.
# i.e. `first_word("   test phrase")` returns `"test"`. 
#
# - `titleize(String)` : returns the input string with its
# first, last, and every word except those which are so-called
# "little words" (i.e. "a" "an" "the" "of" etc) capitalized,
# as in a book title.
# -------------------------------------------------------

def echo(words)
  words
end


def shout(words)
  words.upcase
end


def repeat(words, repeat = 2)
  Array.new(repeat, words).join(" ")
end


def start_of_word(word, characters)
  word[0, characters]
end


def first_word(words)
  words.split(" ").first
end


def titleize(phrase)
  little_words = ["a", "an", "the", "and", "but", "or", "for", "nor",
                  "on" "at", "to", "from", "by", "if", "of", "over"]
  # there are almost certainly more of these.

  phrase.downcase! # in case input phrase is in all-caps, or weirdly capitalized
  words = phrase.split(" ")
  words.each { |word| word.capitalize! unless little_words.include?(word) }

  words.first.capitalize!
  words.last.capitalize!

  words.join(" ")
end
