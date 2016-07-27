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
end

class LinkedList
  include Enumerable
  attr_accessor :head, :tail

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
    @head.next == @tail
  end

  def get(key)
    link = @head.next
    until link.nil?
      return link.val if link.key == key
      link = link.next
    end
    nil
  end

  def include?(key)
    curr_link = @head.next
    until curr_link.nil?
      return true if curr_link.key == key
      curr_link = curr_link.next
    end
    false
  end

  def insert(key, val)
     link = @head

     until link == @tail
       link = link.next
       if link.key == key
         link.val = val
         return
       end
     end

     prev_link = link.prev
     new_link = Link.new(key, val)

     prev_link.next = new_link
     new_link.prev = prev_link
     new_link.next = @tail
     @tail.prev = new_link
   end


   def remove(key)
     link = @head
     until link == @tail
       link = link.next
       if link.key == key
         link.prev.next = link.next
         link.next.prev = link.prev
         return
       end
     end
   end

  def each
    link = @head
    until link.next == @tail
      link = link.next
      yield(link)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
