class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left, @right = nil, nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root
      return BinarySearchTree.insert!(@root, value)
    else
      @root = BSTNode.new(value)
      return @root
    end
  end

  def find(value)
    return BinarySearchTree.find!(@root, value)
  end

  def inorder
    return BinarySearchTree.inorder!(@root)
  end

  def postorder
    return BinarySearchTree.postorder!(@root)
  end

  def preorder
    return BinarySearchTree.preorder!(@root)
  end

  def height
    return BinarySearchTree.height!(@root)
  end

  def min
    return BinarySearchTree.min(@root)
  end

  def max
    return BinarySearchTree.max(@root)
  end

  def delete(value)
    return BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) unless node

    if value > node.value
      if node.right
        BinarySearchTree.insert!(node.right, value)
      else
        node.right = BSTNode.new(value)
        return node
      end
    else
      if node.left
        BinarySearchTree.insert!(node.left, value)
      else
        node.left = BSTNode.new(value)
        return node
      end
    end

  end

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value

    if node.value < value
      return BinarySearchTree.find!(node.right, value)
    else
      return BinarySearchTree.find!(node.left, value)
    end
  end

  def self.preorder!(node)
    return [] unless node
    return [node.value] if BinarySearchTree.height!(node) < 1

    left = BinarySearchTree.preorder!(node.left)
    right = BinarySearchTree.preorder!(node.right)

    return [node.value] + left + right
  end

  def self.inorder!(node)
    return [] unless node
    return [node.value] if BinarySearchTree.height!(node) < 1

    left = BinarySearchTree.inorder!(node.left)
    right = BinarySearchTree.inorder!(node.right)
    return left + [node.value] + right
  end

  def self.postorder!(node)
    return [] unless node
    return [node.value] if BinarySearchTree.height!(node) < 1

    left = BinarySearchTree.postorder!(node.left)
    right = BinarySearchTree.postorder!(node.right)

    return left + right + [node.value]
  end

  def self.height!(node)
    return -1 unless node
    return 0 if (node.left.nil? && node.right.nil?)

    return 1 + [BinarySearchTree.height!(node.left), BinarySearchTree.height!(node.right)].max
  end

  def self.max(node)
    return nil unless node
    return node unless node.right

    return BinarySearchTree.max(node.right)
  end

  def self.min(node)
    return nil unless node
    return node unless node.left

    return BinarySearchTree.min(node.left)
  end

  def self.delete_min!(node)
    return nil unless node
    left_node = node.left
    return node.right if left_node.nil?

    if left_node.left.nil?
      node.left = left_node.right
    else
      BinarySearchTree.delete_min!(left_node)
    end
  end

  def self.delete!(node, value)
    return nil unless node

    if node.value < value
      return nil unless node.right

      if node.right.value == value
        r_left = BinarySearchTree.max(node.right.left)
        r_right = BinarySearchTree.min(node.right.right)
        node.right = [r_left, r_right].max
      else
        BinarySearchTree.delete!(node.right, value)
      end
    else
      return nil unless node.left

      if node.left.value == value
        r_left = BinarySearchTree.max(node.left.left)
        r_right = BinarySearchTree.min(node.left.right)
        node.left = [r_left, r_right].max
      else
        BinarySearchTree.delete!(node.left, value)
      end

    end
  end
end
