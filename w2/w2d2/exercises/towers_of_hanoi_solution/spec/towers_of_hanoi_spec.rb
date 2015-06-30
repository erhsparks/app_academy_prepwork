require 'towers_of_hanoi'

describe TowersOfHanoi do
  let(:towers_of_hanoi) { TowersOfHanoi.new() }

  describe '#initialize' do
    it 'creates an array of towers, which are themselves arrays' do
      expect(
        towers_of_hanoi.instance_variable_get(:@towers)
      ).to be_an_instance_of(Array)

      3.times do |i|
        expect(
          towers_of_hanoi.instance_variable_get(:@towers)[i]
        ).to be_an_instance_of(Array)
      end
    end

    it 'creates towers of the correct size' do
      expect(
        towers_of_hanoi.instance_variable_get(:@towers)[0].length
      ).to eq(3)

      [1, 2].each do |i|
        expect(
          towers_of_hanoi.instance_variable_get(:@towers)[i].length
        ).to eq(0)
      end
    end
  end
end
