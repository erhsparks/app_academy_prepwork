#!/usr/bin/env ruby

# -------------------------------------------------------
# 00_hello_friend.rb - Lizzi Sparks - May 2016
#
# `Friend` class:
# Methods:
# - `Friend#greeting(opt'l String)` :  If `String` not
# specified returns `"Hello!"`, otherwise returns
# `"Hello, [String]!"`.
# 
# -------------------------------------------------------

class Friend
  def greeting(who = nil)
    if who.nil?
      "Hello!"
    else
      "Hello, #{who}!"
    end
  end
end
