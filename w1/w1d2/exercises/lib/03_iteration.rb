#!/usr/bin/env ruby

# -------------------------------------------------------
# 03_iteration.rb - Lizzi Sparks - May 2016
#
# Methods:
# - `factors(Integer)` : returns an array containing all
# factors of `Integer`.
#
# - `Array#bubble_sort! { opt'l block }` : sorts an array
# into and order determined by the block. If no block
# given, sorts array into ascending order.
#
# - `Array#bubble_sort { opt'l block }` : does as above but
# returns a new array, rather than modifying the input array.
#
# - `substrings(String)` : returns an array containing every
# unique sub-string within `String`.
#
# - `subwords(String, dictionary array) : returns an array
# of words found in `dictionary` that are sub-strings of
# `String`.
#
# - `doubler(array of integers)` : returns an array containing
# values equal to double the corresponding value in the
# input array. i.e. `doubler([0, 5, 2])` returns `[0, 10, 4]`.
#
# - `Array#my_each { block }`   : mimics `Array#each`.
# - `Array#my_map { block }`    : mimics `Array#map`.
# - `Array#my_select { block }` : mimics `Array#select`.
# - `Array#my_inject { block }` : mimics `Array#inject`.
#
# - `concatenate(array of strings)` : returns a string
# containing every element of the input array, concatenated
# from `array[0] + array[1] + ... + array[-1]` (i.e. left to
# right.
#
# -------------------------------------------------------

def factors(num)
  factors = []
  (1..num).each { |test_num| factors << test_num if num % test_num == 0 }

  factors
end


class Array
  def bubble_sort!(&prc)
    prc ||= Proc.new { |num1, num2| num1 <=> num2 }
    (0...self.length).each do
      for a in 0 ... (self.length - 1) do
        b = a + 1
        self[a], self[b] = self[b], self[a] if prc.call(self[a], self[b]) == 1
      end
    end

    self
  end

  def bubble_sort(&prc)
    sorted_array = self.dup
    sorted_array.bubble_sort!(&prc)
  end
end


def substrings(string)
  sub_strings = []
  for start_index in 0 ... string.length do
    for end_index in start_index ... string.length do
      sub_strings << string[start_index .. end_index]
    end
  end

  sub_strings.uniq
end

def subwords(word, dictionary)
  words = []
  substrings(word).each { |string| words << string if dictionary.include?(string) }

  words.uniq
end


def doubler(array)
  array.map { |element| element *= 2 }
end


class Array
  def my_each(&prc)
    for i in 0...self.length do
      prc.call(self[i])
    end

    self
  end
end


class Array
  def my_map(&prc)
    mapped = []
    self.my_each { |element| mapped << prc.call(element) }
  
    mapped
  end

  def my_select(&prc)
    selected = []
    self.my_each { |element| selected << element if prc.call(element) }

    selected
  end

  def my_inject(&blk)
    accumulator = self.first
    self.drop(1).my_each { |element| accumulator = blk.call(accumulator, element) }

    accumulator
  end
end


def concatenate(strings)
  strings.inject(:+)
end





# Instructions:

# ### Factors
#
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.


# ### Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the array so that it is in sorted order.
#
# > Bubble sort, sometimes incorrectly referred to as sinking sort, is a
# > simple sorting algorithm that works by repeatedly stepping through
# > the list to be sorted, comparing each pair of adjacent items and
# > swapping them if they are in the wrong order. The pass through the
# > list is repeated until no swaps are needed, which indicates that the
# > list is sorted. The algorithm gets its name from the way smaller
# > elements "bubble" to the top of the list. Because it only uses
# > comparisons to operate on elements, it is a comparison
# > sort. Although the algorithm is simple, most other algorithms are
# > more efficient for sorting large lists.
#
# Hint: Ruby has parallel assignment for easily swapping values:
# http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
#
# After writing `bubble_sort!`, write a `bubble_sort` that does the same
# but doesn't modify the original. Do this in two lines using `dup`.
#
# Finally, modify your `Array#bubble_sort!` method so that, instead of
# using `>` and `<` to compare elements, it takes a block to perform the
# comparison:
#
# ```ruby
# [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
# ```
#
# #### `#<=>` (the **spaceship** method) compares objects. `x.<=>(y)` returns
# `-1` if `x` is less than `y`. If `x` and `y` are equal, it returns `0`. If
# greater, `1`. For future reference, you can define `<=>` on your own classes.
#
# http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator


# ### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).


# ### Doubler
# Write a `doubler` method that takes an array of integers and returns an
# array with the original elements multiplied by two.


# ### My Each
# Extend the Array class to include a method named `my_each` that takes a
# block, calls the block on every element of the array, and then returns
# the original array. Do not use Enumerable's `each` method. I want to be
# able to write:
#
# ```ruby
# # calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
#      2
#      3
#      1
#      2
#      3
#
# p return_value # => [1, 2, 3]
# ```


# ### My Enumerable Methods
# * Implement new `Array` methods `my_map` and `my_select`. Do
#   it by monkey-patching the `Array` class. Don't use any of the
#   original versions when writing these. Use your `my_each` method to
#   define the others. Remember that `each`/`map`/`select` do not modify
#   the original array.
# * Implement a `my_inject` method. Your version shouldn't take an
#   optional starting argument; just use the first element. Ruby's
#   `inject` is fancy (you can write `[1, 2, 3].inject(:+)` to shorten
#   up `[1, 2, 3].inject { |sum, num| sum + num }`), but do the block
#   (and not the symbol) version. Again, use your `my_each` to define
#   `my_inject`. Again, do not modify the original array.


# ### Concatenate
# Create a method that takes in an `Array` of `String`s and uses `inject`
# to return the concatenation of the strings.
#
# ```ruby
# concatenate(["Yay ", "for ", "strings!"])
# # => "Yay for strings!"
# ```
