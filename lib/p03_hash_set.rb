require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    raise "Only unique numbers" if include?(key)
    resize! if num_buckets == @count
    self[key] << key
    @count += 1
  end

  def include?(key)
    return true if self[key].include?(key)
    false
  end

  def remove(key)
    raise "Number doesn't exist" unless include?(key)
    self[key].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % @num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets *= 2
    store_new = []
    @num_buckets.times {store_new << Array.new}
    @store.each do |bucket|
      bucket.each do |key|
        store_new[key.hash % @num_buckets] << key
      end
    end
    @store = store_new
  end
end
