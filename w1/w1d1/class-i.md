# Class (Part I)

## Goals
- Know that a class is a blueprint for an object.
- Know how to extend a class.

## What is a class?

A class is simply a blueprint for an object. It provides the definitions
for all of the object's methods, as well as a set of instructions for
how the object is constructed and how it stores information. As we've
said before, everything in Ruby is an object, and classes are no
exception. Interestingly, `Class` is itself an instance of `Class`. Wow,
meta!

```ruby
[2] pry(main)> Class.is_a?(Object)
=> true
[3] pry(main)> Class.class
=> Class
```

## Extending a class

It is possible to add functionality to a class by **extending** (or
**monkey-patching**) it. We can accomplish this by opening up the class
definition and writing our new method definitions inside of it, like so:

```ruby
class String
  def palindrome?
    self == self.reverse
  end
end
```

Luckily, opening up the `String` class definition doesn't overwrite the
existing version of the class; all the built-in `String` functionality
remains intact. All we've done here is define a new method,
`palindrome?`, inside of `String`. This isn't like defining a method on
its own at the root level (global scope); the `palindrome?` method can
only be called on an instance of the `String` class. You'll notice that
we use a special variable called `self` inside of the method definition.
`self` refers to the object on which the current method is being called.
Say we run the following code:

```ruby
[6] pry(main)> "foo".palindrome?
=> false
```

When the `palindrome?` method gets called on `"foo"`, we enter the
method body. At this point in the program, `self` points to the string
itself (`"foo"`). Since `"foo"` is not equal to `"foo".reverse`, the
method returns false.

## Equality methods

In the previous reading, we learned a few common methods for gaining
information on objects. Another one of these is the `==` method, which
compares two objects and returns `true` if they are equal. In general,
we want two objects to be equal if they have the same value. This works
well for all built-in Ruby classes:

```ruby
2 == 2 # => true
2 == 4 # => false

s1 = "this"
s2 = "this" # different string, same value
s1 == s2 # => true
```

However, by default, an `Object` doesn't know how to compare itself to
other objects. For instance, if you define a new class, `Fraction`:

```ruby
class Fraction
  attr_reader :numerator, :denominator
  def initialize(numerator, denominator)
    @numerator, @denominator = [numerator, denominator]
  end
end

Fraction.new(3, 6) == Fraction.new(1, 2) # => false
```

The proper thing for `Fraction` to do is to know that 3/6 is equal to
1/2. But Ruby doesn't know this without you telling it. Instead, it will
do the only thing it knows how; it will ask whether the two `Fraction`
objects point to the same thing in memory. This is not true: they're
two different objects which represent the same fractional value.

We can rebuild it... we have the technology:

```ruby
class Fraction
  # ...
  def ==(other)
    # first, check if we're comparing two fractions. Comparing two
    # different types of objects should return false
    return false unless (other.is_a?(Fraction))

    (numerator * other.denominator) == (other.numerator * denominator)
  end
end
```

There are a number of other equality operations, but this is the most
important one. We'll learn about the others in time. If you can't
wait, you can read a good
[write-up by Skorks][skorks-on-equality]. Also see [SO][so-equals].

[skorks-on-equality]: http://www.skorks.com/2009/09/ruby-equality-and-object-comparison/
[so-equals]: http://stackoverflow.com/questions/7156955/whats-the-difference-between-equal-eql-and/7157051#7157051

