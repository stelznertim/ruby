def merge_sort(array)
  if array.size < 2
    array
  else
    left = merge_sort(array[0...array.size / 2])
    right = merge_sort(array[array.size / 2...array.size])
    merge(left, right)
  end
end

def merge(left, right, array = [])
  (left.size + right.size).times do
    if left.empty?
      array << right.shift
    elsif right.empty?
      array << left.shift
    else
      comparison = left <=> right
      array << if comparison == -1
                 left.shift
               elsif comparison == 1
                 right.shift
               else
                 left.shift
               end
    end
  end
  array
end

pp merge_sort([1, 5, 4, 7, 6, 9, 2, 10, 0])
