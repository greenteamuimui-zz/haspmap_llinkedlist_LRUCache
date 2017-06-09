class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    answer = 0

    self.each_with_index do |el, idx|
      answer += el.hash * (idx + 1)
    end

    answer
  end
end

class String
  def hash
    answer = 0

    self.each_char.with_index do |ch, idx|
      answer += ch.ord.hash * (idx + 1)
    end

    answer
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    answer = 0
    self.each do |k,v|
      answer += k.hash + v.hash
    end
    answer
  end
end
