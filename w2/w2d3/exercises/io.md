# I/O Exercises

* Write a number guessing game. The computer should choose a number
  between 1 and 100. It should prompt the user for guesses. Each
  time, it will prompt the user for a guess; it will return too high
  or too low. It should track the number of guesses the player took.
* Write a program that prompts the user for a file name, reads that
  file, shuffles the lines, and saves it to the file
  "{input_name}-shuffled.txt". You could create a random number using
  the Random class, or you could use the `shuffle` method in array.
* You've written an RPN calculator. Practice by rewriting your version
  better than you had before. It should have a user interface which
  reads from standard input one operand or operator at a time. You
  should be able to invoke it as a script from the command line. You
  should be able to, optionally, give it a filename on the command
  line, in which case it opens and reads that file instead of reading
  user input.
    * See the `if __FILE__ == $PROGRAM_NAME` trick described in the
      [debugger chapter][underscore_file_trick].
    * `5 1 2 + 4 * + 3 -` should return `14`

[underscore_file_trick]: https://github.com/appacademy/ruby-curriculum/blob/master/w1d1/debugging/debugger.md#write-code-thats-testable
