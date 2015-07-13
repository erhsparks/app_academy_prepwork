require 'board'

describe 'Board' do
  let(:board) { Board.new }

  def place_marks(marks, sym)
    marks.each { |pos| board.place_mark(pos, sym) }
  end

  def fill_cats_game
    [[0, 0], [1, 1], [1, 2], [2, 1]].each do |pos|
      board.place_mark(pos, :X)
    end

    [[0, 1], [0, 2], [1, 0], [2, 0], [2, 2]].each do |pos|
      board.place_mark(pos, :O)
    end
  end

  before do
    class Board
      def get_grid
        send(:grid)
      end
    end
  end

  describe "grid" do
    it "should have a private accessor method" do
      expect(board.get_grid).to be_an_instance_of(Array)
      expect { board.grid }.to raise_error(NoMethodError)
    end
  end

  describe 'initialize' do
    it "should create a 3 by 3 grid of nil values" do
      expect(board.get_grid.length).to be 3

      (0..2).each do |i|
        expect(board.get_grid[i].length).to be 3

        board.get_grid[i].each do |cell|
          expect(cell).to be nil
        end
      end
    end
  end

  describe 'place_mark' do
    it 'should change the value of a square' do
      board.place_mark([0, 0], :X)

      expect(board.get_grid[0][0]).to be :X
    end
  end

  describe 'empty?' do
    it 'should return true when the square is empty' do
      expect(board.empty?([0, 0])).to be_truthy
    end

    it 'should return false when the square has a mark' do
      place_marks([[0, 0]], :X)

      expect(board.empty?([0, 0])).to be_falsey
    end
  end

  describe 'winner' do
    it 'should return :X when :X has won a row' do
      place_marks([[0, 0], [0, 1], [0, 2]], :X)

      expect(board.winner).to be :X
    end

    it 'should return :O when :O has won a column' do
      place_marks([[0, 2], [1, 2], [2, 2]], :O)

      expect(board.winner).to be :O
    end

    it 'should return nil when there is no winner' do
      expect(board.winner).to be nil

      fill_cats_game

      expect(board.winner).to be nil
    end

    it 'should handle diagonals' do
      place_marks([[0, 0], [1, 1], [2, 2]], :X)

      expect(board.winner).to be :X
    end

    it 'should handle diagonals' do
      place_marks([[0, 2], [1, 1], [2, 0]], :X)

      expect(board.winner).to be :X
    end
  end

  describe 'over?' do
    it "shouldn't return false positives" do
      expect(board.over?).to be_falsey

      place_marks([[0, 0], [0, 1]], :X)
      place_marks([[0, 2]], :O)

      expect(board.over?).to be_falsey
    end

    it "should return true when the game is won" do
      place_marks([[0, 0], [0, 1], [0, 2]], :X)

      expect(board.over?).to be_truthy
    end

    it "should return true when the cat has the game" do
      fill_cats_game

      expect(board.over?).to be_truthy
    end
  end
end

