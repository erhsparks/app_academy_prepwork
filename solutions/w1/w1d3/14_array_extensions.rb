class Array
  def sum
    sum = 0
    each { |el| sum += el }
    sum
  end

  def sum
    # Alternative using inject
    inject(0) { |sum, el| sum + el }
  end

  def square!
    each_index { |i| self[i] = self[i] * self[i] }
    self
  end

  def square!
    # Alternative using map
    map! { |el| el * el }
  end

  def square
    dup.square!
  end
end

