# Tic-Tac-Toe

Let's write a Tic-Tac-Toe game!

* You should have a `Board` class and a `Game` class. The board should
  have methods like `#over?`, `winner`, `empty?(pos)`, `place_mark(pos,
  mark)`, etc.
* If you want to be a little fancy, read the attached `bracket-methods`
  reading.
* The `Game` class should have a `play` method that loops, reading in
  user moves. When the game is over, exit the loop.
* You should have a class that represents a human player
  (`HumanPlayer`), and another class for a computer player
  (`ComputerPlayer`). Start with the human player first.
* Both `HumanPlayer` and `ComputerPlayer` should have the same API; they
  should have the same set of public methods. This means they should be
  interchangeable.
    * Your `Game` class should be passed two player objects on
      instantiation; because both player classes have the same API, the
      game should not know nor care what kind of players it is given.
* Keep the computer AI simple: make a winning move if available; else
  move randomly.

For the AI logic: we'd like to make a move, see if we've won, and then
undo the move. However, if we try to set a board position to nil, our
code throws an error. Rather then making the grid public, write a
`remove_mark` method for the board class that doesn't throw an error.

Define a `grid` instance variable. You probably want a private reader
for this.

Board
* grid
  - private accesssor
  - nested arrays of nil
* place_mark
  - expects ([0, 0], :X) as arguments
* empty?
  - takes ([0, 0]) as an argument
* winner
  - should return a position

HumanPlayer
* get_move
  - expects entries of the form '0, 0'

Player
* attr_accessor `mark`

Note that the specs are written to help you build the game in this
manner; there are other implementations that would also work but not
pass the specs. We choose to make the tradeoff to sacrifice flexibility
in implementation for the ability to offer you more support in
implementing this particular solution. Don't worry, you'll have plenty
of opportunities to make larger-scale design decisions going forward!
