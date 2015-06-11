class BattleshipGame
  def initialize
    @player = HumanPlayer.new
    @board = Board.new
    @hit = false
  end

  def attack(pos)
    if board[pos] == :s
      @hit = true
    else
      @hit = false
    end

    board[pos] = :x
  end

  def count
    board.count(:s)
  end

  def declare_winner
    puts "Congratulations. You win!"
  end

  def display_status
    system("clear")
    board.display
    puts "It's a hit!" if hit?
    puts "There are #{count} ships remaining."
  end

  def game_over?
    board.won?
  end

  def hit?
    @hit
  end

  def play
    play_turn until game_over?
    declare_winner
  end

  def play_turn
    pos = nil

    until valid_play?(pos)
      display_status
      pos = player.get_play
    end

    attack(pos)
  end

  def valid_play?(pos)
    pos.is_a?(Array) && board.in_range?(pos)
  end

  protected
  attr_reader :board, :player
end

class Board
  DISPLAY_HASH = {
    nil => " ",
    :s => " ",
    :x => "x"
  }

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def initialize(grid = self.class.default_grid)
    @grid = grid
    populate_grid
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

  def count(sym)
    grid.flatten.select { |el| el == :s }.length
  end

  def display
    header = (0..9).to_a.join("  ")
    p "  #{header}"
    grid.each_with_index { |row, i| display_row(row, i) }
  end

  def display_row(row, i)
    chars = row.map { |el| DISPLAY_HASH[el] }.join("  ")
    p "#{i} #{chars}"
  end

  def empty?(pos = nil)
    if pos
      self[pos].nil?
    else
      grid.flatten.compact.empty?
    end
  end

  def full?
    grid.flatten.none?(&:nil?)
  end

  def in_range?(pos)
    pos.all? { |x| x.between?(0, grid.length) }
  end

  def place_random_ship
    raise "hell" if full?
    pos = random_pos

    until empty?(pos)
      pos = random_pos
    end

    self[pos] = :s
  end

  def populate_grid(count = 10)
    count.times { place_random_ship }
  end

  def random_pos
    [rand(10), rand(10)]
  end

  def won?
    grid.flatten.none? { |el| el == :s }
  end

  protected
  attr_reader :grid
end

class HumanPlayer
  def initialize(name)
    @name = name
  end

  def get_play
    gets.chomp.split(",").map { |el| Integer(el) }
  end

  def prompt
    puts "Please enter a target square (i.e., '3,4')"
    print "> "
  end
end

if __FILE__ == $PROGRAM_NAME
  BattleshipGame.new.play
end
