require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  attr_accessor :prc
  def initialize(max, prc = Proc.new { |x| x**2 })
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map.get_2(key))
    else
      calc!(key)
      eject! if self.count > @max
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    value = @prc.call(key)
    p "Key: #{key}"
    p "Value: #{value}"
    link = @store.append(key, value)
    @map.set(key, link)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.remove(link.key)
    @store.append(link.key, link.val)
  end

  def eject!
    first_link_key = @store.first.key
    @map.delete(first_link_key)
    @store.remove(first_link_key)
  end
end
