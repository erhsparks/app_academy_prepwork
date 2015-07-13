class ComputerPlayer
  attr_reader :name
  attr_accessor :mark

  def initialize(name)
    @name = name
  end

  def get_move
    moves = []
    (0..2).each do |row|
      (0..2).each do |col|
        moves << [row, col] if board[row, col].nil?
      end
    end

    moves.each do |move|
      return move if wins?(move)
    end

    return moves.sample
  end

  def wins?(move)
    board[*move] = mark
    if board.winner == mark
      board.remove_mark(move)
      true
    else
      board.remove_mark(move)
      false
    end
  end

  def display(board)
    @board = board
  end

  private

  attr_reader :board
end
