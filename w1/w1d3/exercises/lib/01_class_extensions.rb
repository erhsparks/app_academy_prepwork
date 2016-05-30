#!/usr/bin/env ruby

# -------------------------------------------------------
# 01_class_extensions.rb - Lizzi Sparks - May 2016
#
# Methods:
# - `String#caesar(Integer)` : returns a string in which
# each letter in `String` has been "shifted" by `Integer`
# number of letters, rolling back to "a" or "A" (depending
# on case of input letter) after end of alphabet is reached.
# i.e. `"ab yz CC".caesar(3)` returns `"de bc FF"`.
#
# - `String#cypher(options hash)` : helper method for
# `String#caesar`.
# `options = {letter: char, shift: Integer, upcase: true/false}`
# Returns a single character: `:letter` shifted by `:shift`.
# `:upcase` helps determine alphabet start and end letters
# (i.e. "a" vs "A"). 
#
# - `String#is_upcase?` : returns `true` if `String` is
# in uppercase.
#
# - `Hash#difference(Hash2)` : returns a new hash containing
# key-value pairs from both hashes -- as long as a given KEY
# appears ONLY in ONE of the two hashes (i.e. not in both).
# i.e. `{a: "a", b: "b"}.difference({b: "cat", d: "frog"})`
# returns `{a: "a", d: "frog"}`.
#
# - `Fixnum#stringify(Integer <= 16)` : mimics
# `Fixnum#to_s(base)`, where `base` is any integer up to base 16.
#
# -------------------------------------------------------

class String
  def caesar(shift = 1)
    shifted = ""
    self.each_char do |letter|
      cypher_options = { letter: letter, shift: shift, upcase: false }
      cypher_options[:upcase] = true if letter.is_upcase?

      shifted << cypher(cypher_options)
    end
    
    shifted
  end

  def is_upcase?
    self == self.upcase
  end

  def cypher(options)
    if options[:upcase]
      first = "A".ord
      final = "Z".ord
    else
      first = "a".ord
      final = "z".ord
    end

    letter = options[:letter].ord
    letter += options[:shift]
    letter = ( letter % (final + 1) ) + first  if letter > final

    letter.chr
  end
end


class Hash
  def difference(other_hash)
    uniq = {}
    self.each { |key,val| uniq[key] = val unless other_hash.keys.include?(key) }
    other_hash.each { |key,val| uniq[key] = val unless self.keys.include?(key) }

    uniq
  end
end


class Fixnum
  def stringify(base)
    raise "Bases between 2 and 16 only!" unless base >= 2 && base <= 16
    return "0" if self == 0

    keys = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    values = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f) # spec wants lower case, eww
    base_digit = Hash[keys.zip(values)]

    pow = 0
    stringified = ""
    until self / (base ** pow) == 0 do
      current_digit = ( self / (base ** pow) ) % base
      stringified = base_digit[current_digit] + stringified

      pow += 1
    end

    stringified
  end
end





# Instructions:

# String: Caesar cipher
#
# * Implement a Caesar cipher: http://en.wikipedia.org/wiki/Caesar_cipher
#
# Example:
#   `"hello".caesar(3) # => "khoor"`
#
# * Assume the text is all lower case letters.
# * You'll probably want to map letters to numbers (so you can shift
#   them). You could do this mapping yourself, but you will want to use
#   the [ASCII codes][wiki-ascii], which are accessible through
#   `String#ord` or `String#each_byte`. To convert back from an ASCII code
#   number to a character, use `Fixnum#chr`.
# * Important point: ASCII codes are all consecutive!
#     * In particular, `"b".ord - "a".ord == 1`.
# * Lastly, be careful of the letters at the end of the alphabet, like
#   `"z"`! Ex.: `caesar("zany", 2) # => "bcpa"`

# Bonus: Refactor your `String#caesar` method to work with strings containing
# both upper- and lowercase letters.


# Hash: Difference
#
# Write a method, `Hash#difference(other_hash)`. Your method should return
# a new hash containing only the keys that appear in one or the other of
# the hashes (but not both!) Thus:
#
# ```ruby
# hash_one = { a: "alpha", b: "beta" }
# hash_two = { b: "bravo", c: "charlie" }
# hash_one.difference(hash_two)
#  # => { a: "alpha", c: "charlie" }
# ```


# Stringify
#
# In this exercise, you will define a method `Fixnum#stringify(base)`,
# which will return a string representing the original integer in a
# different base (up to base 16). **Do not use the built-in
# `#to_s(base)`**.
#
# To refresh your memory, a few common base systems:
#
# |Base 10 (decimal)     |0   |1   |2   |3   |....|9   |10  |11  |12  |13  |14  |15  |
# |----------------------|----|----|----|----|----|----|----|----|----|----|----|----|
# |Base 2 (binary)       |0   |1   |10  |11  |....|1001|1010|1011|1100|1101|1110|1111|
# |Base 16 (hexadecimal) |0   |1   |2   |3   |....|9   |A   |B   |C   |D   |E   |F   |
#
# Examples of strings your method should produce:
#
# ```ruby
# 5.stringify(10) #=> "5"
# 5.stringify(2)  #=> "101"
# 5.stringify(16) #=> "5"
#
# 234.stringify(10) #=> "234"
# 234.stringify(2)  #=> "11101010"
# 234.stringify(16) #=> "EA"
# ```
#
# Here's a more concrete example of how your method might arrive at the
# conversions above:
#
# ```ruby
# 234.stringify(10) #=> "234"
# (234 / 1)   % 10  #=> 4
# (234 / 10)  % 10  #=> 3
# (234 / 100) % 10  #=> 2
#                       ^
#
# 234.stringify(2) #=> "11101010"
# (234 / 1)   % 2  #=> 0
# (234 / 2)   % 2  #=> 1
# (234 / 4)   % 2  #=> 0
# (234 / 8)   % 2  #=> 1
# (234 / 16)  % 2  #=> 0
# (234 / 32)  % 2  #=> 1
# (234 / 64)  % 2  #=> 1
# (234 / 128) % 2  #=> 1
#                      ^
# ```
#
# The general idea is to each time divide by a greater power of `base`
# and then mod the result by `base` to get the next digit. Continue until
# `num / (base ** pow) == 0`.
#
# You'll get each digit as a number; you need to turn it into a
# character. Make a `Hash` where the keys are digit numbers (up to and
# including 15) and the values are the characters to use (up to and
# including `F`).
