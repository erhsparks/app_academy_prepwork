require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
end

if $PROGRAM_NAME == __FILE__
  jane = HumanPlayer.new('jane')
  garry = ComputerPlayer.new('garry')
  g = Game.new(jane, garry)
  g.play
end
