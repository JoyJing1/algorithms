require 'byebug'

class BinaryMinHeap
  def initialize(&prc)
    @prc = prc || Proc.new{ |a, b| a <=> b }
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[@store.length - 1] = @store[@store.length - 1], @store[0]
    last = @store.pop()
    BinaryMinHeap.heapify_down(@store, 0)
    last
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length-1)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    children = []

    child1 = 2 * parent_index + 1
    child2 = 2 * parent_index + 2

    children.push(child1) if child1 < len
    children.push(child2) if child2 < len

    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)

    prc ||= Proc.new{ |a, b| a <=> b }

    complete = false
    until complete
      complete = true
      children = child_indices(len, parent_idx)
      return array if children.empty?

      if children[1]
        child_idx = prc.call(array[children[0]], array[children[1]]) < 0 ? children[0] : children[1]
      else
        child_idx = children[0]
      end

      if child_idx && (prc.call(array[parent_idx], array[child_idx]) > 0)
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
        parent_idx = child_idx
        complete = false
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new{ |a, b| a <=> b }

    complete = false
    until complete || child_idx == 0
      complete = true
      parent_idx = parent_index(child_idx)

      if prc.call(array[parent_idx], array[child_idx]) > 0
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
        complete = false
        child_idx = parent_idx
      end

    end
    array
  end
end
