# RPN Calculator with I/O

We're going to start today's project by writing a Reverse Polish
Notation calculator. Download the project skeleton [here][zip] and see
the spec file for a quick overview of Reverse Polish Notation, as well
as specs for your calculator code.

[zip]: ./w2d2.zip

Once you've finished implementing the basic calculator (all specs
green), it's time to go back, refactor, and improve it by adding some
new functionality. You should be able to invoke it as a script from the
command line. You should be able to, optionally, give it a filename on
the command line, in which case it opens and reads that file:

```
# calculator_instructions.txt
5 2 + 4 *

# command prompt
~$ ruby 12_rpn_calculator.rb calculator_instructions.txt
28 #=> printed result
```

If no filename argument is passed, it should have a user interface that
reads from standard input one operand or operator at a time. If the user
hits `enter` with no operand, the calculator should run and output its
result.

```
~$ ruby 12_rpn_calculator.rb
5
2
+
4
*

28 #=> printed result, program ends
```

**BONUS**: Write specs for the I/O functionality of your new and
improved RPN calculator.
