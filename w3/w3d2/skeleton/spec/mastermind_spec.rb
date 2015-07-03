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
      # uccode = Code.parse("BBBB")
      # lccode = Code.parse("bbbb")
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

end


describe Game do
  before do
    $stdin = StringIO.new("BBBB\n")
  end


end
