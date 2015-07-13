require 'game'

describe "ComputerPlayer" do
  let(:comp) { ComputerPlayer.new('Bonzo') }
  let(:board) { Board.new }

  before do
    def place_marks(marks, sym)
      marks.each { |pos| board.place_mark(pos, sym) }
    end
  end

  describe "initialize" do
    it "should set an instance variable to the given name" do
      expect(comp.instance_variable_get(:@name)).to eq('Bonzo')
    end

    it "shouldn't set a board instance variable" do
      expect(comp.instance_variable_get(:@board)).to be nil
    end
  end
  
  describe "display" do
    it "should set a `board` instance variable" do
      comp.display(board)
      expect(comp.instance_variable_get(:@board)).to be_an_instance_of(Board)
    end
  end

  describe "get_move" do
    it "should return a position" do
      comp.display(board)
      expect(comp.get_move).to be_an_instance_of(Array)
    end

    it "should return a winning move when one is available" do
      place_marks([[0, 0], [1, 0]], :O)
      comp.mark = :O
      comp.display(board)
      expect(comp.get_move).to eq([2, 0])
    end

    it "should return a random move when no winning move is available" do
      moves = []
      10.times do |i|
        c = ComputerPlayer.new('Gizmo')
        c.mark = :O
        c.display(Board.new)
        moves << c.get_move  
      end

      expect(moves.uniq.length).to be > 1
    end
  end
end

