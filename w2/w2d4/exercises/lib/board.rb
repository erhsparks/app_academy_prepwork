class Board
  attr_reader :marks

  def initialize
    @grid = Array.new(3) { Array.new(3) }
    @marks = [:X, :O]
  end

  def [](row, col)
    grid[row][col]
  end

  def []=(row, col, value)
    raise "mark already placed there!" unless empty?([row, col])
    grid[row][col] = value
  end
  
  def over?
    grid.flatten.none? { |pos| pos.nil? } || winner
  end

  def winner
    (0..2).each do |row|
      marks.each do |mark|
        return mark if (0..2).all? { |col| self[row, col] == mark }
      end
    end

    (0..2).each do |col|
      marks.each do |mark|
        return mark if (0..2).all? { |row| self[row, col] == mark }
      end
    end

    marks.each do |mark|
      return mark if (0..2).all? do |step|
        self[step, step] == mark
      end
    end

    marks.each do |mark|
      return mark if (0..2).all? do |step|
        self[step, 2 - step] == mark
      end
    end

    nil
  end

  def empty?(pos)
    self[*pos].nil?
  end

  def place_mark(pos, mark)
    self[*pos] = mark
  end

  def remove_mark(pos)
    grid[pos[0]][pos[1]] = nil
  end

  private

  attr_accessor :grid
end
