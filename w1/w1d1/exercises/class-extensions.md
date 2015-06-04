# Class Extensions

## Array

### Finding Uniques

Monkey-patch the Array class with your own `uniq` method, called
`my_uniq`. The method should return the unique elements, in the order
they first appeared:

```ruby
[1, 2, 1, 3, 3].my_uniq # => [1, 2, 3]
```

Do not use the built-in `uniq` method!

### Two Sum

Write a new `Array#two_sum` method that finds all pairs of positions
where the elements at those positions sum to zero.

NB: ordering matters. I want each of the pairs to be sorted smaller
index before bigger index. I want the array of pairs to be sorted
"dictionary-wise":

```ruby
[-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
```

* `[0, 2]` before `[1, 2]` (smaller first elements come first)
* `[0, 1]` before `[0, 2]` (then smaller second elements come first)

### My Transpose

To represent a *matrix*, or two-dimensional grid of numbers, we can
write an array containing arrays which represent rows:

```ruby
rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]

row1 = rows[0]
row2 = rows[1]
row3 = rows[2]
```

We could equivalently have stored the matrix as an array of
columns:

```ruby
cols = [
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]
```

Write a method, `my_transpose`, which will convert between the
row-oriented and column-oriented representations. You may assume square
matrices for simplicity's sake. Usage will look like the following:

```ruby
matrix = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8]
]

matrix.my_transpose
 # => [[0, 3, 6],
 #    [1, 4, 7],
 #    [2, 5, 8]]
```

Don't use the built-in `transpose` method!

## String

### Caesar cipher

* Implement a [Caesar cipher][caesar-cipher]. Example:
  `"hello".caesar(3) # => "khoor"`
* Assume the text is all lower case letters.
* You'll probably want to map letters to numbers (so you can shift
  them). You could do this mapping yourself, but you will want to use
  the [ASCII codes][wiki-ascii], which are accessible through
  `String#ord` or `String#each_byte`. To convert back from an ASCII code
  number to a character, use `Fixnum#chr`.
* Important point: ASCII codes are all consecutive!
    * In particular, `"b".ord - "a".ord == 1`.
* Lastly, be careful of the letters at the end of the alphabet, like
  `"z"`! Ex.: `caesar("zany", 2) # => "bcpa"`

[caesar-cipher]: http://en.wikipedia.org/wiki/Caesar_cipher

## Bonus

- Refactor your `Array#my_transpose` method to work with any rectangular
matrix (not necessarily a square one).
- Refactor your `String#caesar` method to work with strings containing
  both upper- and lower-case letters.
