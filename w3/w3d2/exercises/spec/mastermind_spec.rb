require 'rspec'
require 'mastermind'


describe Code do
  describe "::parse" do
    # context "factory methods" do
      it "should return an instance of Code" do
        expect(Code.parse("BBBB")).to be_instance_of(Code)
      end
    # end
  end
end
