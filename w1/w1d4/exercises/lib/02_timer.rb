#!/usr/bin/env ruby

# -------------------------------------------------------
# 02_timer.rb - Lizzi Sparks - May 2016
#
# `Timer` class:
# Methods:
# - `Timer#initialize` : `@seconds` is set to `0`.
#
# - `Timer#time_string` : returns a string formatted as
# "hh:mm:ss" for a given `Timer.seconds` (assigned to
# `@seconds` using `Timer#seconds=` contained in
# `attr_accessor`).
#
# - `Timer#padded(Integer)` : this helper method for
# `Timer#time_string` returns a two-digit string for a
# given `Integer`, i.e. `padded(10)` returns `"10"`, while
# `padded(5)` returns `"05"`.
#
# -------------------------------------------------------

class Timer
  attr_accessor :seconds

  def initialize
    @seconds = 0
  end

  def time_string
    hours = 0
    minutes = 0
    seconds = @seconds

    if seconds / 60 > 0
      minutes = seconds / 60
      seconds %= 60
    end

    if minutes / 60 > 0
      hours = minutes / 60
      minutes %= 60
    end

    "#{padded(hours)}:#{padded(minutes)}:#{padded(seconds)}"
  end

  def padded(number)  
    if number < 10    
      "0" + number.to_s
    else
      number.to_s
    end
  end
end
