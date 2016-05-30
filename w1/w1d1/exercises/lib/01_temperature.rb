#!/usr/bin/env ruby

# -------------------------------------------------------
# 01_temperature.rb - Lizzi Sparks - May 2016
#
# Methods:
# - `ftoc(Fixnum)` : takes a number (a temperature in 
# fahrenheit) and returns that number converted to celsius.
# - `ctof(Fixnum)` : takes a number and returns its
# equivalent in degrees fahrenheit.
# -------------------------------------------------------

def ftoc(temp_fahren)
  temp_celsius = (temp_fahren - 32.0) * 5.0 / 9.0
end


def ctof(temp_celsius)
  temp_fahren = temp_celsius * 9.0 / 5.0 + 32.0
end

