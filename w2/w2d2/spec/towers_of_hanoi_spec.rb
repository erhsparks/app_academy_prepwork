require 'towers_of_hanoi'

describe TowersOfHanoi do
  let(:towers_of_hanoi) { TowersOfHanoi.new() }
  let(:towers) { towers_of_hanoi.instance_variable_get(:@towers) }

  describe '#initialize' do
    it 'creates an array of towers, which are themselves arrays' do
      expect(towers).to be_an_instance_of(Array)

      3.times do |i|
        expect(towers[i]).to be_an_instance_of(Array)
      end
    end

    it 'creates towers of the correct size' do
      expect(towers[0].length).to eq(3)

      [1, 2].each do |i|
        expect(towers[i].length).to eq(0)
      end
    end

    it 'stores discs as integers' do
      expect(towers[0][0]).to be_an_instance_of(Fixnum)

      expect(towers[0][1]).to be < (towers[0][0])
      expect(towers[0][2]).to be < (towers[0][1])
    end
  end

  describe '#move(from_tower, to_tower)' do
    let(:disc) { towers[0].last }

    before :each do
      disc
      towers_of_hanoi.move(0, 1)
    end

    it 'removes disc from tower' do
      expect(towers[0].length).to eq(2)
    end

    it 'adds disc to tower' do
      expect(towers[1].length).to eq(1)
    end    

    it 'adds correct disc to tower' do
      expect(towers[1].last).to eq(disc)
    end

    it "doesn't change uninvolved towers" do
      expect(towers[2].length).to eq(0)
    end
  end

  describe '#valid move?(from_tower, to_tower)' do
    it "doesn't return false negatives" do
      expect(towers_of_hanoi.valid_move?(0, 1)).to be_truthy
    end

    it "doesn't return a false positive for a move from an empty tower" do
      expect(towers_of_hanoi.valid_move?(1, 0)).to be_falsey
    end

    it "doesn't return a false positive for a move onto a larger piece" do
      towers_of_hanoi.move(0, 1)
      expect(towers_of_hanoi.valid_move?(0, 1)).to be_falsey
    end    
  end

  describe '#won?' do
    it "doesn't return false negatives" do
      [[0, 1], [0, 2], [1, 2], [0, 1], [2, 0], [2, 1], [0, 1]].each do |move|
        towers_of_hanoi.move(*move)
      end

      expect(towers_of_hanoi.won?).to be_truthy
    end

    it "doesn't return false positives" do
      expect(towers_of_hanoi.won?).to be_falsey

      [[0, 1], [0, 2], [1, 2], [0, 1]].each do |move|
        towers_of_hanoi.move(*move)
      end

      expect(towers_of_hanoi.won?).to be_falsey
    end
  end
end
