require 'game'

describe "Game" do
  let(:game) { Game.new(HumanPlayer.new('Claire'), ComputerPlayer.new('Gizmo')) }
  
  describe "initialize" do
    it "should store a board as an instance variable" do
      expect(game.instance_variable_get(:@board)).to be_an_instance_of(Board)
    end

    it "should set the current player to the first argument" do
      expect(game.send(:current_player)).to be_an_instance_of(HumanPlayer)
    end
  end

#  describe "play" do
#    it "should call `display` and then `get_move` on current player" do
#      c_p = instance_double("HumanPlayer", name: "Charlie", mark: :X)
#      allow(c_p).to receive(:mark=)
#      allow(c_p).to receive(:display).with(game.instance_variable_get(:@board))
#      allow(c_p).to receive(:get_move)
#
#      expect(c_p).to receive(:display).ordered
#      expect(c_p).to receive(:get_move).ordered
#      Game.new(c_p, ComputerPlayer.new('bob')).play
#    end
#  end

  describe "switch_players!" do

  end
end

describe "Board" do
  describe "remove_mark" do
    it "should set the board at the given position to nil" do
      board = Board.new
      board.instance_variable_get(:@grid)[0][0] = :O
      board.remove_mark([0, 0])
      expect(board.instance_variable_get(:@grid)[0][0]).to be nil
    end
  end
end
