require 'rspec'
require 'mastermind'


describe Code do
  let(:uccode) { Code.parse("BBBB") }
  let(:lccode) { Code.parse("bbbb") }

  describe "::PEGS" do
    it "should be a hash of key/value pairs" do
      expect(Code::PEGS).to be_instance_of(Hash)
    end
  end

  describe "::parse" do
    context "should return an instance of Code" do

      it "it accepts upper case input" do
        expect(uccode).to be_instance_of(Code)
      end

      it "it accepts lower case input" do
        expect(lccode).to be_instance_of(Code)
      end
    end

    it "raises error if input is not a valid peg color" do
      expect { Code.parse("abcd") }.to raise_error
    end
  end

  describe "::random" do
    it "should return an instance of Code" do
      expect(Code.random).to be_instance_of(Code)
    end
  end

  describe "#initialize" do
    it "expects pegs array to be passed in" do
      expect { Code.new }.to raise_error(ArgumentError)
    end

    it "set it as an instance variable" do
      pegs = ["b", "b", "b", "b"]
      code = Code.new(pegs)

      expect(code.pegs).to eq(pegs)
    end
  end

  describe "#[]" do
    it "should index into Code#pegs" do
      pegs = [uccode[0], uccode[1], uccode[2], uccode[3]]
      expect(pegs).to eq(uccode.pegs)
    end
  end

  let(:code0) { Code.parse("oooo") }
  let(:code1) { Code.parse("yyyb") }
  let(:code2) { Code.parse("bboy") }

  describe "#exact_matches" do
    context "only counts matching color and position" do

      it "should return 0 if no colors overlap" do
        expect(uccode.exact_matches(code0)).to eq(0)
      end

      it "should return 0 if color match, but position doesn't" do
        expect(code1.exact_matches(code2)).to eq(0)
      end

      it "should only count exact matches" do
        expect(code0.exact_matches(code2)).to eq(1)
      end
    end
  end

  describe "#near_matches" do
    it "should count all near matches" do
      expect(code1.near_matches(code2)).to eq(2)
    end

    it "should not count exact matches" do
      expect(code0.near_matches(code2)).to eq(0)
    end
  end

  describe "#==" do
    context "takes Code object as an argument" do
      it "should return false if other code is not a Code object" do
        expect(uccode == "BBBB").to be_falsey
      end

      it "should compare pegs of Code objects" do
        expect(uccode == lccode).to be_truthy
        expect(code0 == code1).to be_falsey
      end
    end
  end
end


describe Game do
  let(:game) { Game.new }
  let(:secret_code) { game.instance_variable_get(:@secret_code) }
  let(:code) { Code.parse("BBBB") }
  let(:set_game) { Game.new(code) }



  describe "#initialize" do
    it "should accept secret code as an argument" do
      expect { game }.not_to raise_error
    end

    it "should work without arguments" do
      expect { game }.not_to raise_error
    end

    context "pick a random code if none passed" do
      it "should set secret code" do
        expect(secret_code).to be_truthy
      end

      it "secret_code should be an instance of Code" do
        expect(secret_code).to be_instance_of(Code)
      end
    end
  end

  before do
    $stdin = StringIO.new("bgry\n")
    $stdout = StringIO.new
  end

  describe "#get_guess" do
    it "should parse input and return Code object" do
      expect(game.get_guess).to be_instance_of(Code)
    end
  end

  describe "#display_matches" do
    it "should print near and exact matches" do
      game.display_matches(code)
      expect($stdout.string).to match(/exact/)
      expect($stdout.string).to match(/near/)
    end
  end
end
