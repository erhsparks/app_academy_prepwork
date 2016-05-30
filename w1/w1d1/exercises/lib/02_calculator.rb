#!/usr/bin/env ruby

# -------------------------------------------------------
# 02_calculator.rb - Lizzi Sparks - May 2016
#
# Methods:
# - `add(any number of Numeric numbers)` : returns sum of
# input numbers. Returns `0` if no arguments input.
#
# - `subtract(any number of Numerics)` : returns difference
# of input numbers as (first - second - third - ... - last).
# Returns `0` if no arguments input.
#
# - `sum(an array of Numerics)` : returns sum of numbers in 
# input array. Returns `0` if no arguments input.
#
# - `multiply(any number of Numerics)` : returns product of
# input numbers. Returns `0` if no arguments input.
#
# - `power(Numeric, Integer)` : returns `Numeric ** Integer`.
#
# - `factorial(Integer)` : returns the factorial of `Integer`. 
# -------------------------------------------------------

def add(*numbers)
  numbers.inject(0, :+)
end


def subtract(*numbers)
  if numbers.empty?
    0
  else
    numbers.inject(:-)
  end
end


def sum(numbers)
  numbers.inject(0, :+)
end


def multiply(*numbers)
  if numbers.empty?
    0
  else
    numbers.inject(:*)
  end
end


def power(number, power) # this method will only be correct for integer powers
  result = 1.0

  if power < 1
    power.abs.times {result /= number}
  else
    power.times {result *= number}
  end

  result
end


def factorial(number)
  if number < 0
    raise
  elsif number == 0 || number == 1 # base cases
    1
  else
    number *= factorial(number - 1)
  end
end
