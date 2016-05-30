#!/usr/bin/env ruby

# -------------------------------------------------------
# 05_my_hash_set.rb - Lizzi Sparks - May 2016
#
# `MyHashSet` class: mimics ruby's `Set` class, with elements
# being stored in the `keys` of the `@store` hash and their
# corresponding `values` set to `true`.
# Methods:
# - `MyHashSet#initialize` : sets attribute `@store` to an
# empty hash.
#
# - `MyHashSet#insert(Object)` : inserts an object into the
# `MyHashSet`s `@store`.
# 
# - `MyHashSet#include?(Object)` : returns `true` if the object
# is stored in the `MyHashSet`.
# 
# - `MyHashSet#delete(Object)` : deletes the object from the set.
# 
# - `MyHashSet#to_a` : returns an array of all the
# objects in the set (keys of `@store`).
# 
# - `MyHashSet#union(MyHashSet2)` : returns a new `MyHashSet`
# whose members are all the elements of both input sets (with
# no duplicates, i.e. if an element is found in both).
# 
# - `MyHashSet#intersect(MyHashSet2)` : returns a new `MyHashSet`
# whose members are all the elements which appear in BOTH input
# sets.
# 
# - `MyHashSet#minus(MyHashSet2)` : returns a new `MyHashSet`
# whose members are all the elements of the input set EXCEPT
# those which also are members of `MyHashSet2`.
# 
# - `MyHashSet#symmetric_difference(MyHashSet2)` : returns a
# MyHashSet object containing only the elements that are unique
# to each MyHashSet (i.e. omits any elements that are contained
# in both.
# 
# - `MyHashSet#==(Object)` : returns `true` only if Object is
# a `MyHashSet` of equal size to the input `MyHashSet`, and
# contains exactly the same member elements.
#
# -------------------------------------------------------

class MyHashSet
  def initialize
    @store = {}
  end

  def insert(element)
    @store[element] = true
  end

  def include?(element)
    @store.keys.include?(element)
  end

  def delete(element)
    @store.delete(element)
  end

  def to_a
    elements = []
    @store.each_key { |key| elements << key }

    elements
  end

  def union(set2)
    new_set = MyHashSet.new
    self.to_a.each { |element| new_set.insert(element) }
    set2.to_a.each { |el| new_set.insert(el) unless new_set.include?(el) }

    new_set
  end

  def intersect(set2)
    new_set = MyHashSet.new
    self.to_a.each { |element| new_set.insert(element) if set2.include?(element) }

    new_set
  end

  def minus(set2)
    new_set = self
    set2.to_a.each { |element| new_set.delete(element) if set2.include?(element) }

    new_set
  end

  def symmetric_difference(set2)
    new_set = MyHashSet.new
    self.to_a.each { |element| new_set.insert(element) unless set2.include?(element) }
    set2.to_a.each { |element| new_set.insert(element) unless self.include?(element) }

    new_set
  end

  def ==(object)
    object.is_a?(MyHashSet) && (object.to_a.size == self.to_a.size) &&
      self.to_a.all? { |element| object.include?(element) }
  end
end





# Instructions:

# MyHashSet
#
# Ruby provides a class named `Set`. A set is an unordered collection of
# values with no duplicates.  You can read all about it in the documentation:
#
# http://www.ruby-doc.org/stdlib-2.1.2/libdoc/set/rdoc/Set.html
#
# Let's write a class named `MyHashSet` that will implement some of the
# functionality of a set. Our `MyHashSet` class will utilize a Ruby hash to keep
# track of which elements are in the set.  Feel free to use any of the Ruby
# `Hash` methods within your `MyHashSet` methods.
#
# Write a `MyHashSet#initialize` method which sets an empty hash object to
# `@store`. Next, write an `#insert(el)` method that stores `el` as a key
# in `@store`, storing `true` as the value. Write an `#include?(el)`
# method that sees if `el` has previously been `insert`ed by checking the
# `@store`; return `true` or `false`.
#
# Next, write a `#delete(el)` method to remove an item from the set.
# Return `true` if the item had been in the set, else return `false`.  Add
# a method `#to_a` which returns an array of the items in the set.
#
# Next, write a method `set1#union(set2)` which returns a new set which
# includes all the elements in `set1` or `set2` (or both). Write a
# `set1#intersect(set2)` method that returns a new set which includes only
# those elements that are in both `set1` and `set2`.
#
# Write a `set1#minus(set2)` method which returns a new set which includes
# all the items of `set1` that aren't in `set2`.


# Bonus
#
# - Write a `set1#symmetric_difference(set2)` method; it should return the
#   elements contained in either `set1` or `set2`, but not both!
# - Write a `set1#==(object)` method. It should return true if `object` is
#   a `MyHashSet`, has the same size as `set1`, and every member of
#   `object` is a member of `set1`.
