require_relative 'node'

class LinkedList
  attr_reader :header, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append_node(value)
    new_node = Node.new(value)
    @head ||= new_node
    if !@tail
      @tail = new_node
    else
      @tail.next_node = new_node
    end
    @tail = new_node
  end

  def prepend_node(value)
    new_node = Node.new(value, @head)
    @head = new_node
  end

  def list_size
    counter = 0
    current_node = @head
    until current_node.nil?
      counter += 1
      current_node = next_node(current_node)
    end
    counter
  end

  def show_head_node
    @head.to_s
  end

  def show_tail_node
    @tail.to_s
  end

  def at_node_index(index)
    current_node = @head
    index.times do
      current_node = next_node(current_node)
    end
    current_node.to_s
  end

  def pop_node
    nil if list_size < 1
    current_node = @head
    current_node = next_node(current_node) until current_node.next_node == @tail
    current_node.next_node = nil
    @tail = current_node
  end

  def contains?(value)
    current_node = @head
    contains = false
    current_node.data == value ? contains = true : current_node = next_node(current_node) until current_node.nil? || contains == true

    contains
  end

  def next_node(current_node)
    current_node.next_node
  end

  def find(value)
    current_node = @head
    counter = 0
    until current_node.data == value || current_node.nil?
      current_node = next_node(current_node)
      counter += 1
    end
    return nil if current_node.nil?

    counter
  end

  def to_s
    current_node = @head
    list_size.times do
      print "( #{current_node.data} ) ->"
      current_node = next_node(current_node)
    end
    print ' nil'
    puts ' '
  end
end
