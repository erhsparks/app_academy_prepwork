# W1D2: Towers of Hanoi

Welcome to your first day of pair programming! By now you should already
have read our overview of the pair programming process; now it's time to
put it into practice. [Here's a brief guide][pairing-setup] to getting a
remote pairing session up and running.

[pairing-setup]: ../../pairing-setup.md

### Project Instructions

Write a [Towers of Hanoi](http://en.wikipedia.org/wiki/Towers_of_hanoi)
game.

Keep three arrays, which represents the piles of discs. Pick a
representation of the discs to store in the arrays; maybe just a number
representing their size. Don't worry too much about making the user
interface pretty.

In a loop, prompt the user (using
[gets](http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp/))
and ask what pile to select a disc from, and where to put it.

After each move, check to see if they have succeeded in moving all the
discs to the final pile. If so, they win!
