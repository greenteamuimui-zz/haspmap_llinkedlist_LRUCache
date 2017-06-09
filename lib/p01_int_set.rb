class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    is_valid?(num)
    return true if @store[num]
    false
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num >= @max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless include?(num)
      self[num] << num
    else
      raise "Only unique numbers"
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
    else
      raise "Number doesn't exist"
    end
  end

  def include?(num)
    return true if self[num].include?(num)
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % 20]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 4)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    raise "Only unique numbers" if include?(num)
    resize! if num_buckets == @count
    self[num] << num
    @count += 1
  end

  def remove(num)
    raise "Number doesn't exist" unless include?(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    return true if self[num].include?(num)
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets *= 2
    store_new = []
    @num_buckets.times {store_new << Array.new}
    @store.each do |bucket|
      bucket.each do |num|
        store_new[num % @num_buckets] << num
      end
    end
    @store = store_new
  end
end
