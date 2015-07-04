require 'rspec'
require 'hangman'

describe 'Phase I' do
  describe 'ComputerPlayer' do
    describe '#initialize' do
      it 'accepts a dictionary as an argument' do
        dict = ["cat","bat"]
        expect { ComputerPlayer.new(dict) }.to_not raise_error
      end
    end

    describe '#pick_secret_word' do
      it 'returns the length of the picked word' do
        player = ComputerPlayer.new(["foobar"])
        expect(player.pick_secret_word).to eq(6)
      end
    end
  
    describe '#check_guess' do
      let(:player) { ComputerPlayer.new(["foobar"]) }
      before(:each) { player.pick_secret_word }

      it 'accepts a letter as an argument' do
        expect { player.check_guess('z') }.to_not raise_error
      end
      
      it 'returns the indices of the found letters' do
        expect(player.check_guess('o')).to eq([1,2]) 
      end

      it 'handles an incorrect guess' do
        expect(player.check_guess('y')).to eq([])
      end
    end
  end

  describe 'Hangman' do
    let(:players) do 
      referee = double('ComputerPlayer', pick_secret_word: 2, check_guess: [1]) 
      guesser = double('ComputerPlayer', register_secret_length: true, guess: 'f',
                        handle_response: true)

      { guesser: guesser, referee: referee }
    end

    let(:game) { Hangman.new(players) }

    context 'attribute readers' do
      describe '#guesser' do
        it 'is exposed by a reader' do
          expect { game.guesser }.to_not raise_error
        end
      end
      describe '#referee' do
        it 'is exposed by a reader' do
          expect { game.referee }.to_not raise_error
        end
      end
      describe '#board' do
        it 'is exposed by a reader' do
          expect { game.board }.to_not raise_error
        end
      end
    end

    describe '#initialize' do
      it 'accepts an options hash with the guesser and referee' do
        expect { Hangman.new(players) }.to_not raise_error
      end
      
      it 'assigns the players to the correct role' do
        expect(game.guesser).to eq(players[:guesser])
        expect(game.referee).to eq(players[:referee])
      end

      it 'doesn\'t perform any #play setup' do
        expect(game.referee).to_not receive(:pick_secret_word)
        expect(game.guesser).to_not receive(:register_secret_length)
        game
      end
    end

    describe '#play_setup' do
      after(:each) { game.play_setup }
      it 'asks the referee for the secret length' do
        expect(game.referee).to receive(:pick_secret_word)
      end

      it 'has the guesser register the correct secret length' do
        length = game.referee.pick_secret_word
        expect(game.guesser).to receive(:register_secret_length).with(2)
      end

      it 'sets the board to be the same length as the secret length' do
        game.play_setup 
        expect(game.board.length).to eq(2)
      end
    end

    describe '#take_turn' do
      after(:each) do 
        game.play_setup 
        game.take_turn 
      end

      it 'asks the guesser for a guess' do
        expect(game.guesser).to receive(:guess)
      end

      it 'has the referee check the guesser\'s guess' do
        expect(game.referee).to receive(:check_guess)
      end

      it 'updates the board' do
        expect(game).to receive(:update_board)
      end

      it 'has the guesser handle the referee\'s response' do
        expect(game.guesser).to receive(:handle_response)
      end
    end
  end
end

describe 'Phase II' do
  describe 'ComputerPlayer' do
    let(:player) { ComputerPlayer.new(["foobar"]) }
    let(:board)  { [nil,nil,nil,nil,nil,nil] }

    describe '#register_secret_length' do
      it 'accepts a length as an argument' do
        expect { player.register_secret_length(6) }.to_not raise_error
      end
    end

    describe '#guess' do
      before(:each) { player.register_secret_length(6) }

      it 'accepts a board' do
        expect { player.guess(board) }.to_not raise_error
      end

      it 'returns a letter' do
        letter = player.guess(board)
        
        expect(letter).to be_instance_of(String)
        expect(letter.length).to eq(1)
      end
    end

    describe '#handle_response' do
      it 'should not throw an error' do
        player.register_secret_length(6)
        expect { player.handle_response('z', []) }.to_not raise_error
      end
    end
  end
end

describe 'Phase III' do
  describe 'ComputerPlayer' do
    let(:player) { ComputerPlayer.new(["foo", "bar", "foobar"]) }

    describe '#candidate_words' do
      it 'should be exposed by an attribute reader' do
        expect { player.candidate_words }.to_not raise_error
      end
    end

    describe '#register_secret_length' do
      it 'modifies candidate_words' do
        player.register_secret_length(3)
        expect(player.candidate_words.sort).to eq(["foo","bar"].sort)
      end
    end
    
    describe '#handle_response' do
      before(:each) { player.register_secret_length(3) }

      it 'successfully prunes candidate words when letter is found' do
        player.handle_response('o', [1,2])

        expect(player.candidate_words).to eq(["foo"])
      end
      
      it 'successfully prunes candidate_words when letter is not found' do
        player.handle_response('f',[])

        expect(player.candidate_words).to eq(['bar'])
      end

      it 'handles a complicated case' do
        guesser = ComputerPlayer.new(['leer', 'reel', 'real', 'rear'])
        guesser.register_secret_length(4)
        
        guesser.handle_response('r', [0])

        expect(guesser.candidate_words.sort).to eq(['reel','real'].sort)
      end
    end

    describe '#guess' do
      let(:guesser) { ComputerPlayer.new(["reel","keel","meet"]) }
      before(:each) { guesser.register_secret_length(4) }

      it 'returns most common letter in candidate_words' do
        board = [nil,nil,nil,nil] 
        expect(guesser.guess(board)).to eq('e')
      end
      
      it 'handles previous guesses' do
        board = [nil, 'e', 'e', nil]
        expect(guesser.guess(board)).to eq('l')
      end
    end
  end
end
