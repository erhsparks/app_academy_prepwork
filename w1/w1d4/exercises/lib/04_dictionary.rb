#!/usr/bin/env ruby

# -------------------------------------------------------
# 04_dictionary.rb - Lizzi Sparks - May 2016
#
# `Dictionary` class:
# Methods:
# - `Dictionary#initialize` : initializes `@entries` class
# attribute to an empty hash.
#
# - `Dictionary#add(Hash or String)` : if `Hash`, adds `Hash`
# to `@entries`; if `String`, adds `String` as `key` with a
# corresponding `value` of `nil` to `@entries`.
#
# - `Dictionary#keywords` : returns `@entries` sorted by `key`.
#
# - `Dictionary#include?(String)` : returns `true` if `String`
# is one of `@entries`'s `keys`.
#
# - `Dictionary#find(String)` : returns a hash of those
# key-value pairs in `@entries` for which the `keys` contain
# `String`.
#
# - `Dictionary#printable` : returns a string containing all
# the key-value pairs in `@entries` in the form:
# `'[key] "value" \n'`.
# 
# -------------------------------------------------------

class Dictionary
  attr_accessor :entries

  def initialize
    @entries = {}
  end

  def add(entry)
    case entry
    when Hash then @entries.merge!(entry)
    when String then @entries.merge!(entry => nil)
    end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(entry)
    keywords.include?(entry)
  end

  def find(string)
    @entries.select { |key, value| key.include?(string) }
  end

  def printable
    print_string = ""
    keywords.each { |key| print_string << %([#{key}] "#{@entries[key]}"\n) }

    print_string.chomp
  end
end
