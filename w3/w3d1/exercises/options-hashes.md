# Options Hashes

Write a method `super_print` that takes a `String`. This method should
take optional parameters `:times`, `:upcase`, and `:reverse`. Hard-code
reasonable defaults in a `defaults` hash defined in the `super_print`
method. Use `Hash#merge` to combine the defaults with any optional
parameters passed by the user. Do not modify the incoming options
hash. For example:

```ruby
super_print("Hello")                                    #=> "Hello"
super_print("Hello", :times => 3)                       #=> "Hello" 3x
super_print("Hello", :upcase => true)                   #=> "HELLO"
super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"

options = {}
super_print("hello", options)
# options shouldn't change.
```
