class RPNCalculator
  OPERATORS = [:+, :-, :*, :/]

  def self.evaluate_file(file)
    file.each do |line|
      line = line.chomp
      calc = RPNCalculator.new
      puts calc.evaluate(line)
    end
  end

  def self.prompt
    puts "Enter a number or operator (ENTER to quit)"
    print "> "
  end

  def self.run_ui
    calc = RPNCalculator.new
    string = ""

    loop do
      prompt
      input = gets.chomp
      break if input.empty? # Stop asking for input if the user hits ENTER
      string << " #{input}"
    end

    puts calc.evaluate(string)
  end

  def initialize
    @stack = []
  end

  def divide
    perform_op(:/)
  end

  def evaluate(string)
    tokens(string).each do |token|
      case token
      when Integer
        push(token)
      when Symbol
        perform_op(token)
      end
    end

    value
  end

  def minus
    perform_op(:-)
  end

  def operator?(char)
    OPERATORS.include?(char.to_sym)
  end

  def perform_op(op_sym)
    raise "calculator is empty" unless @stack.count >= 2

    right_operand = @stack.pop
    left_operand = @stack.pop

    case op_sym
    when :+
      @stack << left_operand + right_operand
    when :-
      @stack << left_operand - right_operand
    when :*
      @stack << left_operand * right_operand
    when :/
      # `Fixnum#fdiv` is like `/` but makes sure not to round down.
      @stack << left_operand.fdiv(right_operand)
    else
      @stack << left_op << right_op
      raise ArgumentError.new("No operation #{op_sym}")
    end

    self
  end

  def plus
    perform_op(:+)
  end

  def push(num)
    @stack << num
  end

  def times
    perform_op(:*)
  end

  def tokens(string)
    chars = string.split(" ")
    chars.map { |char| operator?(char) ? char.to_sym : Integer(char) }
  end

  def value
    @stack.last
  end
end

if __FILE__ == $PROGRAM_NAME
  # only run this in program mode
  if ARGV.empty?
    # if no file given, read input from the standard input (console)
    # file
    RPNCalculator.run_ui
  else
    File.open(ARGV[0]) do |file|
      puts RPNCalculator.evaluate_file(file)
    end
  end
end
