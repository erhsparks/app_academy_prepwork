def multiply_by_two(nums)
  nums.map { |num| num * 2 }
end

class Array
  def my_each(&prc)
    # using `Array#each` is cheating!`
    self.count.times { |i| prc.call(self[i]) }

    # return original array
    self
  end
end

# this one actually didn't use any Enumerable methods, I think.
def median(nums)
  # sort the numbers; notice that I don't modify nums at all.
  sorted_nums = nums.sort
  while sorted_nums.count > 2
    # remove smallest
    sorted_nums.shift
    # remove largest
    sorted_nums.pop
  end

  # we're left with one or two middle numbers
  sorted_nums.count == 1 ?
    sorted_nums.first : ((sorted_nums[0] + sorted_nums[1]) / 2.0)
end

def concatenate_strings(strings)
  strings.inject("") do |total, string|
    # notice that I don't reassign `total`; that would be superfluous
    # since total is a local parameter to the block. I don't modify it
    # either, I just return the value to use for the next iteration.
    total + string
  end
end
