class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    res = 1
    self.each_with_index do |el, i|
      res ^= i.hash * el.hash
    end
    res
  end
end

class String
  def hash
    self.split("").map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    res = 1
    keys = self.keys.sort
    keys.each do |key|
        res ^= key.hash * self[key].hash
    end
    res
  end
end
