require "rspec"
require "class_extensions"

describe Array do
  describe "#my_uniq" do
    let(:array) { [1, 2, 1, 3, 4, 2] }

    it "returns the unique elements" do
      expect(array.my_uniq).to eq([1, 2, 3, 4])
    end

    it "does not modify the original array" do
      duped_array = array.dup

      array.my_uniq

      expect(array).to eq(duped_array)
    end

    it "does not call the built-in #uniq method" do
      expect(array).not_to receive(:uniq)

      array.my_uniq
    end
  end

  describe "#two_sum" do
    it "returns positions of pairs of numbers that add to zero" do
      expect([5, 1, -7, -5].two_sum).to eq([[0, 3]])
    end

    it "finds multiple pairs" do
      expect([5, -1, -5, 1].two_sum).to eq([[0, 2], [1, 3]])
    end

    it "finds pairs with same element" do
      expect([5, -5, -5].two_sum).to eq([[0, 1], [0, 2]])
    end

    it "returns [] when no pair is found" do
      expect([5, 5, 3, 1].two_sum).to eq([])
    end

    it "won't find spurious zero pairs" do
      expect([0, 1, 2, 3].two_sum).to eq([])
    end

    it "will find real zero pairs" do
      expect([0, 1, 2, 0].two_sum).to eq([[0, 3]])
    end
  end

  describe "#my_transpose" do
    let(:arr) { [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ] }

    let(:small_arr) { [
      [1, 2],
      [3, 4]
    ] }

    it "transposes a small matrix" do
      expect(small_arr.my_transpose).to eq([
        [1, 3],
        [2, 4]
      ])
    end

    it "transposes a larger matrix" do
      expect(arr.my_transpose).to eq([
        [1, 4, 7],
        [2, 5, 8],
        [3, 6, 9]
      ])
    end

    it "should not modify the original array" do
      small_arr.my_transpose

      expect(small_arr).to eq([
        [1, 2],
        [3, 4]
      ])
    end

    it "should not call the built-in #transpose method" do
      expect(arr).not_to receive(:transpose)

      arr.my_transpose
    end
  end

  describe "#median" do
    let(:even_array) { [3, 2, 6, 7] }
    let(:odd_array) { [3, 2, 6, 7, 1] }

    it "returns nil for the empty array" do
      expect([].median).to be_nil
    end

    it "returns the element for an array of length 1" do
      expect([1].median).to eq(1)
    end

    it "returns the median of an odd-length array" do
      expect(odd_array.median).to eq(3)
    end

    it "returns the median of an even-length array" do
      expect(even_array.median).to eq(4.5)
    end
  end
end

describe String do
  describe "#caesar" do
    it "encodes a simple word" do
      expect("aaa".caesar(11)).to eq("lll")
    end

    it "wraps around" do
      expect("zzz".caesar(1)).to eq("aaa")
    end

    it "encodes a longer word" do
      expect("catzhatz".caesar(2)).to eq("ecvbjcvb")
    end
  end
end

describe Hash do
  describe "#difference" do
    let(:hash) { { a: 1, b: 2 } }
    let(:overlapping_hash) { { b: 4, c: 3 } }
    let(:non_overlapping_hash) { { c: 3, d: 4 } }

    it "returns the difference of non-overlapping hashes" do
      expect(hash.difference(non_overlapping_hash)).to eq({
        a: 1,
        b: 2,
        c: 3,
        d: 4
      })
    end

    it "returns the difference of overlapping hashes" do
      expect(hash.difference(overlapping_hash)).to eq({
        a: 1,
        c: 3
      })
    end

    it "does not modify the original hashes" do
      duped_hash = hash.dup
      duped_overlapping_hash = overlapping_hash.dup

      hash.difference(overlapping_hash)

      expect(hash).to eq(duped_hash)
      expect(overlapping_hash).to eq(duped_overlapping_hash)
    end
  end
end

describe Fixnum do
  describe "#stringify" do
    it "stringifies numbers in base 10" do
      expect(5.stringify(10)).to eq("5")
      expect(10.stringify(10)).to eq("10")
      expect(42.stringify(10)).to eq("42")
    end

    it "stringifies numbers in base 2" do
      expect(5.stringify(2)).to eq("101")
      expect(10.stringify(2)).to eq("1010")
      expect(42.stringify(2)).to eq("101010")
    end

    it "stringifies numbers in base 16" do
      expect(5.stringify(16)).to eq("5")
      expect(10.stringify(16)).to eq("a")
      expect(42.stringify(16)).to eq("2a")
    end
  end
end
