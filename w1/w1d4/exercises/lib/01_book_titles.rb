#!/usr/bin/env ruby

# -------------------------------------------------------
# 01_book_titles.rb - Lizzi Sparks - May 2016
#
# `Book` class:
# Methods:
# - `Book#title=(String)` : assigns user input `String` to
# class attribute `@title` for a `Book` object. `String`
# is transformed into a conventional title by capitalizing
# all letters except those typically left lower case.
# 
# -------------------------------------------------------

class Book
  attr_reader :title

  def title=(phrase)
    stay_lowercase = %w(the a an and in of)

    words = phrase.downcase.split(" ")
    title = words.map do |word|
      if stay_lowercase.include?(word)
        word
      else
        word.capitalize
      end
    end

    title.first.capitalize!
    title.last.capitalize!

    @title = title.join(" ")
  end
end
