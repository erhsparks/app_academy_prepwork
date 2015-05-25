def factors(num)
  (1..num).select { |i| num % i == 0 }
end

class Array
  def bubble_sort
    self.dup.bubble_sort!
  end

  def bubble_sort!
    sorted = false
    until sorted
      sorted = true

      self.each_index do |index|
        # last element has no next element
        next if (index + 1) == self.count

        # this is getting deeply nested...
        if self[index] > self[index + 1]
          self[index], self[index + 1] = self[index + 1], self[index]
          sorted = false
        end
      end
    end

    self
  end
end

def substrings(string)
  subs = []

  string.length.times do |sub_start|
    ((sub_start + 1)..(string.length)).each do |sub_end|
      sub = string[sub_start...sub_end]

      subs << sub unless subs.include?(sub)
    end
  end

  subs
end

def subwords(word, dictionary_filename)
  dictionary_words = File.readlines(dictionary_filename).map(&:chomp)

  substrings(word).select do |substr|
    dictionary_words.include?(substr)
  end
end

require 'set'
def faster_subwords(word, dictionary_filename)
  # compare for length 100 word
  dictionary_words_array =
    File.readlines(dictionary_filename).map(&:chomp)

  # this will turn the array into a `Set` object; `Set#include?` is
  # much faster for a `Set`.
  dictionary_words_set = Set.new(dictionary_words_array)

  substrings(word).select do |substr|
    dictionary_words_set.include?(substr)
  end
end
