require_relative 'linked_list'

list = LinkedList.new
list.appendNode('middle')
list.appendNode('last')
list.prependNode('first')
list.to_s
puts list.list_size
list.show_head_node
list.show_tail_node
list.at_node_index(1)
list.pop_node
puts list.contains?('last')
puts list.contains?('first')
puts list.find('middle')
list.to_s
