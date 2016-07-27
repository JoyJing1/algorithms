require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @start_idx = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index > @length-1
    new_idx = (@start_idx + index) % @capacity
    @store[new_idx]
  end

  # O(1)
  def []=(index, val)
    new_idx = (@start_idx + index) % @capacity
    @store[index] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length <= 0
    @length -= 1
    last_idx = (@length + @start_idx) % @capacity
    @store[last_idx]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length >= @capacity
    @length += 1
    last_idx = (@length + @start_idx - 1) % @capacity
    @store[last_idx] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length <= 0
    @length -= 1
    old_start = @start_idx
    @start_idx = (@start_idx + 1) % @capacity
    @store[old_start]
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length >= @capacity
    @length += 1
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    @store[index]
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)

    (0...@length).each do |i|
      old_i = (@start_idx + i) % (@capacity/2)
      new_store[i] = @store[old_i]
    end
    @start_idx = 0
    @store = new_store
  end
end
