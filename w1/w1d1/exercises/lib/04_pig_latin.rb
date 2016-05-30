#!/usr/bin/env ruby

# -------------------------------------------------------
# 04_pig_latin.rb - Lizzi Sparks - May 2016
#
# Main purpose is to translate an input string into Pig
# Latin, using the 'translate' method.
#
# Global constants:
# - `VOWELS` : an array of the vowels, including y.
# - `ALPHABET` : an array of all the letters of the alphabet,
# both lower (a-z) and upper (A-Z) cases.
#
# Methods:
# - `translate(String)` : returns a string containing the
# input string in Pig Latin.
#
# - `letter?(character)` : returns `true` if input character
# is a letter (i.e. is contained in `ALPHABET` -- see Global
# Constants above).
#
# - `proper_noun?(String)` : returns `true` if first letter
# of input string is upper case.
#
# - `has_no_vowels?(String)` : returns `true` if `String`
# contains no vowels (including y, see `VOWELS` above).
#
# - `begins_with_vowel?(String)` : returns `true` if first
# character in `String` is a vowel (including y, see `VOWELS`).
#
# `String` class --  monkey-patched methods:
# - `String#separate_punctuation` : returns an array of size 3:
# first index contains string of all non-letter characters
# before the first letter in `String`, last index similarly
# contains all non-letter characters after the last letter
# character in `String`, and the middle index holds everything
# in between. i.e. `"?!don't!!".separate_punctuation` returns
# `["?!","don't","!!"]`.
#
# - `String#piggify` : returns a string, the input word in Pig
# Latin. Proper nouns are still proper nouns in Pig Latin, i.e.
# `"Lizzi".piggify` returns `"Izzilay"`. I made up a rule that
# if a word contains zero vowels, it is piggified as:
# `"pssht" -> "sshtpay"`
#
# - `String#first_letter_last` : returns a string containing the 
# second through last letters of `String` followed by the
# first letter. "qu" is treated as a single letter.
# i.e. "hat" -> "ath", "quiet" -> "ietqu".
# -------------------------------------------------------

VOWELS = %W(a e i o u y)
ALPHABET = %W(a b c d e f g h i j k l m n o p q r s t u v w x y z 
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

def translate(phrase)
  pig_words = []

  words = phrase.split(" ")
  words.each do |word|
    l_punct, word, r_punct = word.separate_punctuation

    pig_words << ( l_punct + word.piggify + r_punct )
  end

  pig_words.join(" ")
end


def letter?(char)
  ALPHABET.include?(char)
end

def proper_noun?(word)
  word == word.capitalize
end


def has_no_vowels?(word)
  word.split("").none? { |letter| VOWELS.include?(letter) }
end

def begins_with_vowel?(word)
  VOWELS.include?(word[0])
end

# I realise that any of the above methods could be added to the String class
# extensions below and similarly that any of the below String class monkey
# patches could be methods above in main() but I've split it up this way
# because stylistically I think Object.modify and some_check?(Object) make
# the most sense to read.

class String
  def separate_punctuation
    l_symbols = ""
    r_symbols = ""
    chars = self.split("")
    
    l_symbols << chars.shift until chars.empty? || letter?(chars.first)
    r_symbols = ( chars.pop + r_symbols ) until chars.empty? || letter?(chars.last)
    
    [l_symbols, chars.join(""), r_symbols]
  end
  
  def piggify
    if self == ""
      self
    elsif proper_noun?(self)
      self.downcase.piggify.capitalize
    elsif has_no_vowels?(self)
      self.first_letter_last + "ay"
    else
      word = self
      word = word.first_letter_last until begins_with_vowel?(word)
      word << "ay"
    end
  end

  def first_letter_last
    if self[0..1] == "qu"
      self[2..-1] + self[0..1]
    else
      self[1..-1] + self[0]
    end
  end
end
