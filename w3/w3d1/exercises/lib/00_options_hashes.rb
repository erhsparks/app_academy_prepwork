#!/usr/bin/env ruby

# -------------------------------------------------------
# 00_options_hashes.rb - Lizzi Sparks - May 2016
#
# Methods:
# - `transmogrify(String, Hash)` : returns `String` if
# no options specfied in `Hash`. Possible options include
# any combination of:
#  `:times`  : returned string is `String` `:times` times.
#  `:upcase` : string is made uppercase.
#  `:reverse`: string is reversed.
# 
# -------------------------------------------------------

def transmogrify(string, options = {})
  defaults = {
    times: 1,
    upcase: false,
    reverse: false
  }

  options = defaults.merge(options)

  string = string.upcase if options[:upcase]
  string = string.reverse if options[:reverse]
  string *= options[:times] unless options[:times] == 1

  string
end




# Instructions:

# Options Hashes
#
# Write a method `transmogrify` that takes a `String`. This method should
# take optional parameters `:times`, `:upcase`, and `:reverse`. Hard-code
# reasonable defaults in a `defaults` hash defined in the `transmogrify`
# method. Use `Hash#merge` to combine the defaults with any optional
# parameters passed by the user. Do not modify the incoming options
# hash. For example:
#
# ```ruby
# transmogrify("Hello")                                    #=> "Hello"
# transmogrify("Hello", :times => 3)                       #=> "HelloHelloHello"
# transmogrify("Hello", :upcase => true)                   #=> "HELLO"
# transmogrify("Hello", :upcase => true, :reverse => true) #=> "OLLEH"
#
# options = {}
# transmogrify("hello", options)
# # options shouldn't change.
# ```
