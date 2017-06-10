class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if @head.next == @tail && @tail.prev == @head
    false
  end

  def get(key)
    self.each do |link|
      return link.val if key == link.key
    end
  end

  def get_2(key)
    self.each do |link|
      return link if key == link.key
    end
  end

  def include?(key)
    self.each do |link|
      return true if key == link.key
    end
    false
  end

  def append(key, val)
    if !include?(key)
      link = Link.new(key, val)
      previous = @tail.prev
      @tail.prev = link
      previous.next = link
      link.prev = previous
      link.next = @tail
      return link
    else
      update(key, val)
    end
  end

  def update(key, val)
    self.each do |link|
      link.val = val if key == link.key
    end
  end

  # def remove(key)
  #   link = @head
  #   until link.next.nil?
  #     link = link.next
  #     if key == link.key
  #       next_link = link.next
  #       prev_link = link.prev
  #       link.prev.next, link.next.prev = next_link, prev_link
  #       break
  #     end
  #   end
  # end

  def remove(key)
    self.each do |link|
      if key == link.key
        next_link = link.next
        prev_link = link.prev
        link.prev.next, link.next.prev = next_link, prev_link
        break
      end
    end
  end

  def each(&blk)
    link = @head
    until link.next.next.nil?
      link = link.next
      blk.call(link)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
