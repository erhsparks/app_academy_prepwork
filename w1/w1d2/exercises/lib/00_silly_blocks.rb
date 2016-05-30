#!/usr/bin/env ruby

# -------------------------------------------------------
# 00_silly_blocks.rb - Lizzi Sparks - May 2016
#
# Methods:
# - `reverser { String }` : returns a string with each word
# in the input string in the block reversed.
#
# - `adder(optional Numeric1) { Numeric2 }` : returns sum
# of `Num2 + Num1` or `Num2 + 1` if `Num1` not specified.
#
# - `repeater(opt'l Integer) { any block }` : executes the
# block `Integer` times, or once if `Integer` not specified.
# -------------------------------------------------------

def reverser(&prc)
  words = prc.call

  words.split(" ").map { |word| word.reverse }.join(" ")
end


def adder(number = 1, &prc)
  prc.call + number
end


def repeater(times = 1, &prc)
  times.times { prc.call }
end

