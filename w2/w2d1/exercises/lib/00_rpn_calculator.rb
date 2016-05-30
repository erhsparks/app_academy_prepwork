#!/usr/bin/env ruby

# -------------------------------------------------------
# 00_rpn_calculator.rb - Lizzi Sparks - May 2016
#
# Interactive text-based Reverse Polish Notation calculator!
# Try running '> [path]/00_rpn_calculator' and
# '> [path]/00_rpn_calculator [path]/calculator_instructions.txt'
#
#
# `RPNCalculator` class : Reverse Polish Notation Calculator
# Methods:
# - `RPNCalculator#initialize` : initializes `RPNCalculator`
# attribute `@calculator` to an empty array.
#
# - `RPNCalculator#push(Numeric)` : pushes `Numeric` onto
# `@calculator`
#
# - `RPNCalculator#value` : returns the most recent value
# pushed onto `@calculator`.
#
# - `RPNCalculator#plus` : returns the sum of the last two
# numbers pushed onto `@calculator`.
#
# - `RPNCalculator#minus` : returns the quotient of the
# second-to-last number divided by the last number pushed
# onto `@calculator`.
#
# - `RPNCalculator#times` : returns the product of the last
# two numbers pushed onto `@calculator`.
#
# - `RPNCalculator#divide` : returns the sum of the last two
# numbers pushed onto `@calculator`.
#
# - `RPNCalculator#stack_too_low?` : `raise`s error "calculator
# is empty" if `@calculator` contains less than two elements.
#
# - `RPNCalculator#tokens(String)` : helper method for
# `#evaluate(String)`. Returns an array containg the integers
# and symbols found in `String`, i.e. an input of `'1 2 -'`
# returns `[1, 2, :-]`.
#
# - `RPNCalculator#evaluate(String)` : returns a number, the
# RPN-calculated value of the input string, i.e. an input
# `'1 3 2 - +'` returns `2`.
#
#
# `String` class monkey patches: helpers for `tokens` above^
# - `String#operator?` : returns `true` if String is one of
# '+', '-', '*', or '/'.
#
# - `String#invalid_symbol?` : returns `true` if String is
# not a representation of a number (i.e. if `String.to_f
# == 0
#
#
# w2d3 I/O bonus problem (see above at top for how to run
# from your terminal):
#
# - `RPNCalculator::calculate_from_file(filename)` : reads
# in File filename line by line and solves any RP Notation
# problems within. Prints output to terminal.
#
# - `RPNCalculator::interactive_calculator` : launches an
# interactive calculator, with basic commands 'h' for help,
# 'c' for clear, 'd' for display, and 'q' for quit (any other
# entry is scanned for a numerical value or '+' '-" '*' '/'.
# Invalid entries are ignored.
#
# - `RPNCalculator::welcome_message`, `::goodbye_message` :
# prints a welcome message and a goodbye message, repectively.
# 
# - `RPNCalculator#process(String)` : similar to `#evaluate(String)`
# above but I wanted to be able to input floats as well as
# implementing a few extra features, like 'c' for clea, 'd'
# for display, 'h' for help (see `#help_message`), '' to
# print the evaluated calculation to the terminal, and 'q' to
# quit.
#
# - `RPNCalculator#help_message` : prints a help message
# to the terminal.
#
# -------------------------------------------------------

class RPNCalculator
  attr_accessor :calculator

  def initialize
    @calculator = []
  end

  def push(number)
    @calculator << number
  end

  def value
    @calculator.last
  end

  def plus
    stack_too_low?
    @calculator << @calculator.pop + @calculator.pop
  end

  def minus
    stack_too_low?
    @calculator << -@calculator.pop + @calculator.pop
  end

  def times
    stack_too_low?
    @calculator << @calculator.pop * @calculator.pop
  end

  def divide
    stack_too_low?
    @calculator << 1.0 / @calculator.pop * @calculator.pop
  end

  def stack_too_low?
    raise "calculator is empty" if @calculator.length < 2
  end

  def tokens(string)
    string.split(" ").map do |token|
      if token.operator?
        token = token.to_sym
      elsif token.invalid_symbol?
        raise "invalid symbol detected!"
      else
        token = token.to_i
      end
    end
  end

  def evaluate(string)
    @calculator = []

    input = self.tokens(string)
    input.each do |element|
      case element
      when Fixnum then @calculator << element
      when :+ then self.plus
      when :- then self.minus
      when :* then self.times
      when :/ then self.divide
      end
    end

    @calculator.last
  end
end

class String
  def operator?
    operators = %w( + - * / )
    operators.include?(self)
  end

  def invalid_symbol?
    self.to_i == 0 && self != "0"
  end
end



###################
# w2d3 improved_rpn_calculator code for interactive sessions
# and reading calculation instructions from file:

class RPNCalculator
  def self.calculate_from_file(filename)
    calculator = RPNCalculator.new
    
    calculations = File.readlines(filename)
    calculations.each do |line|
      puts "#{line.strip} = #{calculator.evaluate(line)}" unless line.strip == ""
    end
    # Note: instead of `puts`, could change this to write output to
    # new file named filename-answers.txt, or to back to the same file.
  end

  def self.interactive_calculator
    welcome_message
    
    calculator = RPNCalculator.new
    entry = ""
    until entry == "q"
      print "> "
      entry = gets.chomp
      calculator.process(entry)
    end

    goodbye_message
  end


  def self.welcome_message
    puts "
---------------------- + - * / --------------------------

             Welcome to RPN Calculator!

 Enter 'q' to exit, 'c' to clear calculator,
 'd' to display values currently stored in calculator,
 or 'h' for help at any time.

 Enter your operations one at a time,
 followed by an additional 'enter' to calculate.

 Remember that your first two entries MUST be numbers!

 Begin:"
  end

  def process(entry)
    if entry.to_f != 0.0
      self.push(entry.to_f)
    else
      case entry
      when "0", "00", "0.0" then self.push(entry.to_f)
      when "+" then self.plus
      when "-" then self.minus
      when "*" then self.times
      when "/" then self.divide
      when ""  then puts "= #{self.value}"
      when "c" then self.calculator.pop until self.calculator.empty?
      when "d" then puts "Calculator contains: #{self.calculator.to_s}"
      when "h" then help_message
      end
    end
  end

  def help_message
        puts "
  --------------------------------------------------
 |               RPN Calculator Help                |
 |                                                  |
 | Enter at least two numbers, followed by your     |
 | desired operations:                              |
 |                                                  |
 | '+' for addition                                 |
 | '-' for addition                                 |
 | '*' for multiplication                           |
 | '/' for division.                                |
 |                                                  |
 | Operations are evaluated from left to right:     |
 | '4 2 -' is equivalent to '4 - 2'.                |
 |                                                  |
 | You may input multiple operations:               |
 | '4 2 - 6 *' is equivalent to '(4 - 2) * 6'       |
 | and '6 4 2 - *' is equivalent to '6 * (4 - 2)'.  |
 |                                                  |
 | Additional commands:                             |
 | 'd' to display the calculator's contents         |
 | 'c' to clear the calculator's contents           |
 | 'q' to exit                                      |
 | 'h' to display this help message again.          |
  --------------------------------------------------"
  end

  def self.goodbye_message
    puts "
                      Goodbye!

---------------------- + - * / --------------------------"
  end
end


########################################################
if __FILE__ == $PROGRAM_NAME
  if ARGV[0]
    RPNCalculator::calculate_from_file(ARGV[0])
  else
    RPNCalculator::interactive_calculator
  end
end
########################################################
