# Exercises

## Blocks

### `benchmark`

Write a `benchmark` method that takes a block. It should run the block,
and return the amount of time (in seconds) it took to run the block. You
can do this using Ruby's `Time.now` and subtraction. Once you have this
basic functionality, add an optional argument allowing the user to
specify how many times the block should be run.

### `race`

Now write a `race` method that takes two procs and returns the one with
the shorter runtime. Use your `benchmark` method to do this. Here, too,
allow the user to pass in the number of times to run the procs.

### `eval_block`

Write an `eval_block` method that takes some arguments and a block. It
should call the block, passing all the arguments to the block at once
(individually, not as an array) using the splat operator. If the user
doesn't supply the block, it should print out "NO BLOCK GIVEN!".

To take possibly multiple arguments, check out the Ruby
[splat operator][splat-operator]. Note that the wonderful splat
operator can allow a method to take **any** number of arguments. It
**also** allows us to pass an array of arguments to a method **as
seperate arguments**. See the example below:

```ruby
#ex1
my_neat_method(thing1, thing2, banana)

#ex2
my_arg_array = [thing1, thing2, banana]
my_neat_method(*my_arg_array)
```

In the example above, `my_neat_method` gets the arguments in **exactly**
the same way in both `ex1` and `ex2`. It has **no idea** the arguments
were **ever** in `my_arg_array`. The splat operator passed in the
individual arguments as separate, distinct, discrete, un-array-ified
arguments.

Examples of calling `eval_block`:

```ruby
# Example calls to eval_block
eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end
# Washington, Kerry won 23 votes.
# => nil

eval_block(1,2,3,4,5) do |*args|
  args.inject(:+)
end
# => 15

eval_block(1, 2, 3)
# => "NO BLOCK GIVEN"
```

[splat-operator]: http://kconrails.com/2010/12/22/rubys-splat-operator

## Iteration

### Factors

Write a method `factors(num)` that prints out all the factors of a given
number.

### Bubble Sort

Implement [Bubble sort][wiki-bubble-sort] in a method,
`Array#bubble_sort!`. Your method should modify the array so that it is
in sorted order.

> Bubble sort, sometimes incorrectly referred to as sinking sort, is a
> simple sorting algorithm that works by repeatedly stepping through
> the list to be sorted, comparing each pair of adjacent items and
> swapping them if they are in the wrong order. The pass through the
> list is repeated until no swaps are needed, which indicates that the
> list is sorted. The algorithm gets its name from the way smaller
> elements "bubble" to the top of the list. Because it only uses
> comparisons to operate on elements, it is a comparison
> sort. Although the algorithm is simple, most other algorithms are
> more efficient for sorting large lists.

Hint: Ruby has [parallel assignment][parallel-assignment] for easily
swapping values.

After writing `bubble_sort!`, write a `bubble_sort` that does the same
but doesn't modify the original. Do this in two lines using `dup`.

Finally, modify your `Array#bubble_sort!` method so that, instead of
using `>` and `<` to compare elements, it takes a block to perform the
comparison:

```ruby
[1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
[1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
```

#### `#<=>` (the **spaceship** method)
[compares objects][so-spaceship]. `x.<=>(y)` returns `-1` if `x` is
less than `y`. If `x` and `y` are equal, it returns `0`. If greater,
`1`. For future reference, you can define `<=>` on your own classes.

[wiki-bubble-sort]: http://en.wikipedia.org/wiki/bubble_sort
[parallel-assignment]: http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
[so-spaceship]: http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator

### Substrings and Subwords

Write a method, `substrings`, that will take a `String` and return an
array containing each of its substrings. Don't repeat substrings.
Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
"t"]`.

Your `substrings` method returns many strings that are not true English
words. Let's write a new method, `subwords`, which will call
`substrings`, filtering it to return only valid words. To do this,
`subwords` will accept both a string and a dictionary (an array of
words).

## Enumerables

### Doubler
Write a `doubler` method that takes an array of integers and returns an
array with the original elements multiplied by two.

### My Each
Extend the Array class to include a method named `my_each` that takes a
block, calls the block on every element of the array, and then returns
the original array. Do not use Enumerable's `each` method. I want to be
able to write:

```ruby
# calls my_each twice on the array, printing all the numbers twice.
return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end
# => 1
     2
     3
     1
     2
     3

p return_value # => [1, 2, 3]
```

### My Enumerable Methods
* Implement new `Array` methods `my_map` and `my_select`. Do
  it by monkey-patching the `Array` class. Don't use any of the
  original versions when writing these. Use your `my_each` method to
  define the others. Remember that `each`/`map`/`select` do not modify
  the original array.
* Implement a `my_inject` method. Your version shouldn't take an
  optional starting argument; just use the first element. Ruby's
  `inject` is fancy (you can write `[1, 2, 3].inject(:+)` to shorten
  up `[1, 2, 3].inject { |sum, num| sum + num }`), but do the block
  (and not the symbol) version. Again, use your `my_each` to define
  `my_inject`. Again, do not modify the original array.

### Concatenate
Create a method that takes in an `Array` of `String`s and uses `inject`
to return the concatenation of the strings.

```ruby
concatenate(["Yay ", "for ", "strings!"])
# => "Yay for strings!"
```
