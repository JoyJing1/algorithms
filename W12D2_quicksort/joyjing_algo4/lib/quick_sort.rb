class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[rand(array.length)]

    left = []
    center = []
    right = []

    array.each do |el|
      if el == pivot
        center.push(el)
      elsif el < pivot
        left.push(el)
      else
        right.push(el)
      end
    end

    sort1(left) + center + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= Proc.new{ |a, b| a <=> b }

    pivot_idx = partition(array, start, length, &prc)

    l_length = pivot_idx - start
    r_length = length - l_length - 1

    sort2!(array, start, l_length, &prc) if l_length > 1
    sort2!(array, pivot_idx + 1, r_length, &prc) if r_length > 1

    array
  end

  def self.partition(array, start, length, &prc)
    return start if length <= 1

    prc ||= Proc.new{ |a, b| a <=> b }
    pivot = array[start]
    pivot_idx = start

    (1...length).each do |i|
      idx = start + i

      if prc.call(pivot, array[idx]) > 0
        if i == 1
          array[pivot_idx], array[idx] = array[idx], array[pivot_idx]
        else
          array[pivot_idx] = array[idx]
          array[idx] = array[pivot_idx+1]
          array[pivot_idx+1] = pivot
        end
        pivot_idx += 1
      end

    end
    pivot_idx
  end

end
