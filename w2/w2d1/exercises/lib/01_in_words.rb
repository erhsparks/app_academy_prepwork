#!/usr/bin/env ruby

# -------------------------------------------------------
# .rb - Lizzi Sparks - May 2016
#
# `Fixnum` class extensions:
# Methods:
# - `Fixnum#in_words(optional Fixnum2)` : returns a string
# containing `Fixnum` in words, using helper method
# `#make_string` below. If optional `Fixnum2` specified,
# returns `(self/Fixnum2).in_words`. i.e. `0.in_words`
# returns `'zero'` ; `1000.in_words(100)` returns `'ten'`.
#
# - `Fixnum#string_options : returns a hash containing two
# key/value pairs: {order_of_magnitude: Fixnum,
# adjective: String}`. i.e. `405.string_options`
# returns `{order_of_magnitude: 100, adjective: 'hundred'}`.
# This helper method is for input to `#make_string`.
#
# - `Fixnum#make_string(options hash)` : 
# returns a string containing Fixnum in words, using an
# options hash like the one generated by `#string_options`
# to appropriately label each subsection of larger numbers.
# Calls back to `#in_words` for each subsection, i.e.
# `45134.make_string(o)` calls `45.in_words + 'thousand' +
# 100.in_words + 'hundred' + 34.in_words`.
#
# - `Fixnum#multiple_of?(Fixnum2)` : returns `true` if
# input number is a multiple of `Fixnum2`.
#
# - `Fixnum#has_trillions?` : returns `true` only if
# input number is >= 1e12 (has a trillions digit).
#
# - `Fixnum#has_billions?` : as `#has_trillions?` but for
# a billions digit (Fixnum >= 1e9).
#
# - `Fixnum#has_millions?` : as `#has_trillions?` but for
# a millions digit (Fixnum >= 1e6).
#
# - `Fixnum#has_thousands?` : as `#has_trillions?` but for
# a thousands digit (Fixnum >= 1e3).
#
# - `Fixnum#has_hundreds?` :  as `#has_trillions?` but for
# a hundreds digit (Fixnum >= 100).
#
# Global Constants:
# - `Fixnum::ONES_DIGIT_NAMES` : hash whose `keys` are the
# integers `0` through `9` and whose corresponding `values`
# are strings containing the name of that integer in words,
# i.e. `0 => 'zero'`.
#
# - `Fixnum::TEEN_NUMBER_NAMES` : as `ONES_DIGIT_NAMES` but
# for `10` through `19`.
#
# - `Fixnum::TENS_DIGIT_NAMES` : as `ONES_DIGIT_NAMES` for
# `20`, `30`, ..., `90`.
#
# -------------------------------------------------------

class Fixnum
  def in_words(divisor = 1)
    number = self.to_i / divisor.to_i
    
    options = {}
    until options.nil?
      if number.string_options == options
        options = nil
      else
        options = number.string_options
        wordy = number.make_string(options)
      end
    end

    wordy
  end

  def string_options
    case when self.has_trillions?
      {order_of_magnitude: 1e12, adjective: "trillion"}
    when self.has_billions?
      {order_of_magnitude: 1e9, adjective: "billion"}
    when self.has_millions?
      {order_of_magnitude: 1e6, adjective: "million"}
    when self.has_thousands?
      {order_of_magnitude: 1e3, adjective: "thousand"}
    when self.has_hundreds?
      {order_of_magnitude: 100, adjective: "hundred"}
    else
      {order_of_magnitude: nil, adjective: ""}
    end
  end

  def make_string(options)
    words = []
    number = self.to_i

    if options[:order_of_magnitude]
      tens = options[:order_of_magnitude].to_i
      words << %(#{number.in_words(tens)} #{options[:adjective]})
      words << (number % tens).in_words unless number.multiple_of?(tens)
    elsif number < 10
      words << ONES_DIGIT_NAMES[number]
    elsif number < 20
      words << TEEN_NUMBER_NAMES[number]
    else
      words << TENS_DIGIT_NAMES[number / 10 * 10]
      words << ONES_DIGIT_NAMES[number % 10] unless number.multiple_of?(10)
    end

    words.join(" ")
  end

  def multiple_of?(test_number)
    self % test_number.to_i == 0
  end

  def has_trillions?
    self / (1e12.to_i) != 0
  end

  def has_billions?
    self / (1e9.to_i) != 0
  end

  def has_millions?
    self / (1e6.to_i) != 0
  end

  def has_thousands?
    self / (1e3.to_i) != 0
  end

  def has_hundreds?
    self / (1e2.to_i) != 0
  end

  ONES_DIGIT_NAMES = {
    0 => "zero", 1 => "one", 2 => "two", 3 => "three",
    4 => "four", 5 => "five", 6 => "six",
    7 => "seven", 8 => "eight", 9 => "nine"
  }

  TEEN_NUMBER_NAMES = {
    10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen",
    14 => "fourteen", 15 => "fifteen", 16 => "sixteen",
    17 => "seventeen", 18 => "eighteen", 19 => "nineteen"
  }

  TENS_DIGIT_NAMES = { 
    20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty",
    60 => "sixty", 70 => "seventy", 80 => "eighty", 90 => "ninety",
  }
end
