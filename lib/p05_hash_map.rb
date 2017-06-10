require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if !include?(key)
      resize! if num_buckets == @count
      bucket(key).append(key, val)
      @count += 1
    else
      bucket(key).update(key, val)
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def get_2(key)
    bucket(key).get_2(key)
  end

  def delete(key)
    return nil unless include?(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&blk)
    @store.each do |linked_list|
      linked_list.each do |link|
        blk.call([link.key, link.val])
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets *= 2
    store_new = []
    @num_buckets.times {store_new << LinkedList.new}
    @store.each do |linked_list|
      linked_list.each do |link|
        store_new[link.key.hash % @num_buckets].append(link.key, link.val)
      end
    end
    @store = store_new
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % @num_buckets]
  end
end
