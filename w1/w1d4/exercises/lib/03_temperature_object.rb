#!/usr/bin/env ruby

# -------------------------------------------------------
# 03_temperature_object.rb - Lizzi Sparks - May 2016
#
# `Temperature` class:
# Methods:
# - `Temperature#initialize(options hash)` : assigns input
# options hash (which should consist of `{f: Numeric}` or
# `{c: Numeric}`) to class attribute `@temperature`.
#
# - `Temperature::from_celsius(Numeric)` : creates a new
# `Temperature` object with the options hash input
# `{c: Numeric}`.
#
# - `Temperature::from_fahrenheit(Numeric)` : as above,
# but assigns `@temperature` hash to key `:f` instead of
# `:c`.
#
# - `Temperature#in_fahrenheit` : returns a number, either
# `@temperature[:f]` or `@temperature[:c]` converted to
# fahrenheit.
#
# - `Temperature#in_celsuis` : as above but in celsius.
#
# - `Temperature#c_to_f` : returns a `@temperature[:c]`
# converted to fahrenheit.
#
# - `Temperature#f_to_c` : as above for `@temperature[:f]`
# to celsius.
#
#
# `Fahrenheit` class: inherits from `Temperature`
# Methods:
# - `Fahrenheit#initialize(Numeric)` : assigns `{c: Num}`
# to `Temperature.temperature`.
#
# `Celsius` class: inherits from `Temperature`
# Methods:
# - `Celsius#initialize(Numeric)` : assigns `{f: Numeric}`
# to `Temperature.temperature`.
#
# -------------------------------------------------------
class Temperature
  def initialize(temperature)
    @temperature = temperature
  end

  def self.from_celsius(temperature)
    Temperature.new(c: temperature)
  end

  def self.from_fahrenheit(temperature)
    Temperature.new(f: temperature)
  end

  def in_fahrenheit
    if @temperature.has_key?(:f)
      @temperature[:f]
    elsif @temperature.has_key?(:c)
      self.c_to_f
    end
  end

  def c_to_f
    @temperature[:c] * 9.0 / 5.0 + 32.0
  end

  def in_celsius
    if @temperature.has_key?(:c)
      @temperature[:c]
    elsif @temperature.has_key?(:f)
      self.f_to_c
    end
  end

  def f_to_c
    (@temperature[:f] - 32.0) * 5.0 / 9.0
  end
end

class Celsius < Temperature
  def initialize(temperature)
    @temperature = {c: temperature}
  end
end

class Fahrenheit < Temperature
  def initialize(temperature)
    @temperature = {f: temperature}
  end
end
