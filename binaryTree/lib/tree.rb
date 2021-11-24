require_relative 'node'

class BinaryTree
  attr_accessor :tree_values, :root

  def initialize(arr)
    @tree_values = arr
    size = tree_values.length
    @root = build_tree(tree_values, 0, size - 1)
  end

  def build_tree(tree_values, start, ending)
    return if start > ending

    mid = (start + ending) / 2
    root = Node.new(tree_values[mid])
    root.left_child = build_tree(tree_values, start, mid - 1)
    root.right_child = build_tree(tree_values, mid + 1, ending)

    root
  end

  def insert(value)
    tree_values.push(value).sort!.uniq!
    build_tree(tree_values, 0, tree_values.length - 1)
  end

  def delete(value)
    return unless tree_values.include?(value)

    tree_values.delete(value)
    unless root.right_child.nil? && root.left_child.nil?
      tree_values.sort!
      root = build_tree(tree_values, 0, tree_values.length - 1)
    end
    root
  end

  def find(value, node = root)
    return node if node.nil? || node.data == value

    value < node.data ? find(value, node.left_child) : find(value, node.right_child)
  end

  def breadth_first_traversal(node = root, queue = [])
    print "#{node.data} "
    queue << node.left_child unless node.left_child.nil?
    queue << node.right_child unless node.right_child.nil?
    return if queue.empty?

    breadth_first_traversal(queue.shift, queue)
  end

  def pre_order(node = root)
    return if node.nil?

    print "#{node.data} "
    pre_order(node.left_child)
    pre_order(node.right_child)
  end

  def in_order(node = root)
    return if node.nil?

    in_order(node.left_child)
    print "#{node.data} "
    in_order(node.right_child)
  end

  def post_order(node = root)
    return if node.nil?

    post_order(node.left_child)
    post_order(node.right_child)
    print "#{node.data} "
  end

  def height(node = root)
    unless node.nil? || node == root
      node = node.instance_of?(Node) ? find(node.data) : find(note)
    end

    return -1 if node.nil?

    [height(node.left_child), height(node.right_child)].max + 1
  end

  def depth(node = root, parent = root, edges = 0)
    return 0 if node == parent
    return -1 if parent.nil?

    if node < parent.data
      edges += 1
      depth(node, parent.left, edges)
    elsif node > parent.data
      edges += 1
      depth(node, parent.right, edges)
    else
      edges
    end
  end

  def balanced?(node = root)
    return true if node.nil?

    left_height = height(node.left_child)
    right_height = height(node.right_child)

    return true if (left_height - right_height).abs <= 1 && balanced?(node.left_child) && balanced?(node.right_child)

    false
  end

  def rebalance
    in_order
    root = build_tree(tree_values, 0, tree_values.size - 1)
  end

  def inorder_array(node = root, array = [])
    unless node.nil?
      inorder_array(node.left_child, array)
      array << node.data
      inorder_array(node.right_child, array)
    end
    array
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

array = Array.new(15) { rand(1..100) }
bst = BinaryTree.new(array)

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Level order traversal: '
puts bst.breadth_first_traversal

puts 'Preorder traversal: '
puts bst.pre_order

puts 'Inorder traversal: '
puts bst.in_order

puts 'Postorder traversal: '
puts bst.post_order

10.times do
  a = rand(100..150)
  bst.insert(a)
  puts "Inserted #{a} to tree."
end

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Rebalancing...'
bst.rebalance

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Level order traversal: '
puts bst.breadth_first_traversal

puts 'Preorder traversal: '
puts bst.pre_order

puts 'Inorder traversal: '
puts bst.in_order

puts 'Postorder traversal: '
puts bst.post_order
