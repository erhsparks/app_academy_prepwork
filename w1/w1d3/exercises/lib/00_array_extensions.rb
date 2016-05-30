#!/usr/bin/env ruby

# -------------------------------------------------------
# 00_array_extensions.rb - Lizzi Sparks - May 2016
#
# Methods:
# - `Array#sum` : returns an integer, the sum of all
# elements in `Array`. It is assumed that `Array` contains
# only Numerics.
#
# - `Array#square!` : squares each element in `Array`.
# 
# - `Array#square` : as `Array#square!` above but returns
# a new array instead of modifing input array.
#
# - `Array#my_uniq` : mimics `Array#uniq`.
#
# - `Array#two_sum` : returns an array containing arrays of
# paired numbers, let's call them `num1` and `num2`. These
# numbers correspond to the indices of the orignal array
# for which `Array[num1] + Array[num2]` sums to `0`, and
# are sorted in ascending order.
#
# - `Array#median` : returns the median value (middle value
# of a sorted odd-numbered array; average of middle two
# values for an even numbered array).
#
# - `Array#my_transpose` : mimics `Array#transpose`.
#
# -------------------------------------------------------

class Array
  def sum
    self.inject(0, :+)
  end

  def square!
    self.map! { |element| element**2 } 
  end

  def square
    self.map { |element| element**2 } 
  end

  def my_uniq
    uniq = []
    self.each { |element| uniq << element unless uniq.include?(element)}

    uniq
  end

  def two_sum
    two_sums = []
    for i in 0...(self.length - 1) do
      for j in (i + 1)...self.length do
        two_sums << [i, j] if self[i] + self[j] == 0
      end
    end

    two_sums
  end

  def median
    sorted = self.sort
    halfway = sorted.length / 2

    if self.empty? || sorted.length % 2 == 1
      sorted[halfway]
    else
      (sorted[halfway - 1] + sorted[halfway]) / 2.0
    end 
  end

  def my_transpose
    current_col = []
    transposed = []

    self.first.length.times do |i|
      self.each { |elem| current_col << elem[i] }

      transposed << current_col
      current_col = []
    end

    transposed
  end
end







# Instructions:

# Sum
#
# Write an Array method, `sum`, that returns the sum of the elements in the
# array. You may assume that all of the elements are integers.


# Square
#
# Write an array method, `square`, that returns a new array containing the
# squares of each element. You should also implement a "bang!" version of this
# method, which mutates the original array.


# Finding Uniques
#
# Monkey-patch the Array class with your own `uniq` method, called
# `my_uniq`. The method should return the unique elements, in the order
# they first appeared:
#
# ```ruby
# [1, 2, 1, 3, 3].my_uniq # => [1, 2, 3]
# ```
#
# Do not use the built-in `uniq` method!


# Two Sum
#
# Write a new `Array#two_sum` method that finds all pairs of positions
# where the elements at those positions sum to zero.
#
# NB: ordering matters. I want each of the pairs to be sorted smaller
# index before bigger index. I want the array of pairs to be sorted
# "dictionary-wise":
#
# ```ruby
# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
# ```
#
# * `[0, 2]` before `[1, 2]` (smaller first elements come first)
# * `[0, 1]` before `[0, 2]` (then smaller second elements come first)


# Median
#
# Write a method that finds the median of a given array of integers. If
# the array has an odd number of integers, return the middle item from the
# sorted array. If the array has an even number of integers, return the
# average of the middle two items from the sorted array.


# My Transpose
#
# To represent a *matrix*, or two-dimensional grid of numbers, we can
# write an array containing arrays which represent rows:
#
# ```ruby
# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]
#
# row1 = rows[0]
# row2 = rows[1]
# row3 = rows[2]
# ```
#
# We could equivalently have stored the matrix as an array of
# columns:
#
# ```ruby
# cols = [
#     [0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]
#   ]
# ```
#
# Write a method, `my_transpose`, which will convert between the
# row-oriented and column-oriented representations. You may assume square
# matrices for simplicity's sake. Usage will look like the following:
#
# ```ruby
# matrix = [
#   [0, 1, 2],
#   [3, 4, 5],
#   [6, 7, 8]
# ]
#
# matrix.my_transpose
#  # => [[0, 3, 6],
#  #    [1, 4, 7],
#  #    [2, 5, 8]]
# ```
#
# Don't use the built-in `transpose` method!


# Bonus: Refactor your `Array#my_transpose` method to work with any rectangular
# matrix (not necessarily a square one).
