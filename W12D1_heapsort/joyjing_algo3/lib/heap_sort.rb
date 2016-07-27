require_relative "heap"
require 'byebug'

class Array
  def heap_sort!
      prc = Proc.new{ |a, b| b <=> a }

      (0...length).each do |i|
        BinaryMinHeap.heapify_up(self, self.length - 1 - i, &prc)
      end

      max = length - 1
      until max == 0
        self[0], self[max] = self[max], self[0]
        max -= 1

        left, right = self.take(max+1), self.drop(max+1)
        sorted = BinaryMinHeap.heapify_down(left, 0, &prc)
        
        replace(sorted.concat(right))
      end
  end
end
