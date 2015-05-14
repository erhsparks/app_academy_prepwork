# Hash

## Goals

* Familiarize yourself with the selected, important methods here.
* Know that a `Hash` should be used whenever you have keys and values.
* Know:
  * how to access a value by key
  * how to set a value for a key
  * how to delete a key/value

## What's a Hash?

A Hash is a collection of key-value pairs. You can think of a hash
like an array, but instead of the keys being incrementing integer
indices (i.e., 0, 1, 2, 3, etc.), the keys are arbitrary, and can be
any kind of object.

You can create a hash a couple different ways:

```ruby
empty_hash = Hash.new
another_empty_hash = {} # shorter and preferred

capitals = { 'New York' => 'Albany', 'California' => 'Sacramento' }
```

### `Hash#[]`

We can look up values in a hash by its key:

```ruby
capitals = { 'New York' => 'Albany', 'California' => 'Sacramento' }
capitals['New York'] # => 'Albany'
```

### `Hash#each`

We can also *iterate* over the elements of the hash, just like we did
with array:

```ruby
capitals = { 'New York' => 'Albany', 'California' => 'Sacramento' }

capitals.each do |state, capital|
  puts "#{capital} is the capital of #{state}"
end

# => Albany is the capital of New York
#    Sacramento is the capital of California
```

Notice that when we iterate over a hash, each entry in the hash has
both a key and a value.

### `Hash#[]=`

We add a new key and value to a hash like so:

```ruby
capitals = { 'New York' => 'Albany', 'California' => 'Sacramento' }
capitals['Texas'] = 'Austin'

puts capitals
# => { 'New York' => 'Albany', 'California' => 'Sacramento', 'Texas' => 'Austin' }
```

### `Hash#delete`

We can delete a key/value pair in a hash like so:

```ruby
capitals = { 'New York' => 'Albany', 'California' => 'Sacramento' }
capitals.delete('California')

puts capitals
# => { 'New York' => 'Albany' }
```

### `Hash#merge`

We can also merge two hashes together:

```ruby
capitals = { 'New York' => 'Albany', 'California' => 'Sacramento' }
more_capitals = { 'Texas' => 'Austin', 'Alaska' => 'Juneau' }

capitals.merge(more_capitals)
# => { 'New York' => 'Albany', 'California' => 'Sacramento', 'Texas' => 'Austin', 'Alaska' => 'Juneau' }
```

Notice that `hash1.merge(hash2)` is the same as `hash2.merge(hash1)`
here. This isn't always the case; if you have two hashes with the same
keys, duplicate entries in the merged Hash take precedence over the
ones in the calling Hash:

```ruby
h1 = {:a => 'apple', :b => 'bat'}
h2 = {:b => 'bravo', :c => 'charlie'}

h1.merge(h2) # => {:a => 'apple', :b => 'bravo', :c => 'charlie'}
h2.merge(h1) # => {:a => 'apple', :b => 'bat', :c => 'charlie'}
```

Note also that `merge` does not modify either of the hashes, it
creates a new hash which contains the keys and values of both. There
is a bang version (`merge!`) which will modify the method receiver.

### `Hash#keys`

If we want to get all of the keys in a hash we can use the `keys`
method:

```ruby
capitals = { 'New York' => 'Albany', 'California' => 'Sacramento' }

capitals.keys # => ['New York', 'California']
```

Notice that the return value of this method is an *array* of the
hash's keys.

### `Hash#values`

Similarly, we can get all of the values in a hash by using the
Hash#values method:

```ruby
capitals = { 'New York' => 'Albany', 'California' => 'Sacramento' }
capitals.values # => ['Albany', 'Sacramento']
```

### `Hash#has_key?`

We can check if a hash has a specific key by using the `Hash#has_key?`
method:

```ruby
capitals = { 'New York' => 'Albany', 'California' => 'Sacramento' }
capitals.has_key?('New York') # => true
capitals.has_key?('France') # => false
```

## Exercises

Estimated time: 30min

### Set

Ruby provides a class named `Set`. A set is an unordered collection of
values with no duplicates.  You can read all about it in the
[ruby-doc][ruby-set-doc]. Let's write a class named `MyHashSet` that
will implement some of the functionality of a set. Our `MyHashSet` class
will utilize a Ruby hash to keep track of which elements are in the set.
Feel free to use any of the Ruby `Hash` methods within your `MyHashSet`
methods.

Write a `MyHashSet#initialize` method which sets an empty hash object to
`@store`. Next, write a `#insert(el)` method that stores `el` as a key
in `@store`, storing `true` as the value. Write an `#include?(el)`
method that sees if `el` has previously been `insert`ed by checking the
`@store`; return `true` or `false`.

Next, write a `#delete(el)` method to remove an item from the set.
Return `true` if the item had been in the set, else return `false`.
Add a method `#to_a` which returns an array of the items in the set.

Next, write a method `set1#union(set2)` which returns a new set which
includes all the elements in EITHER `set1` or `set2`. Write a
`set1#intersect(set2)` method that returns a new set which includes
only those elements that are in BOTH `set1` and `set2`.

Write a `set1#minus(set2)` method which returns a new set which
includes all the items of `set1` that aren't in `set2`.

[ruby-set-doc]: http://www.ruby-doc.org/stdlib-2.1.2/libdoc/set/rdoc/Set.html
