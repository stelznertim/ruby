def fibs(num)
  array = []
  0.upto(num) do |i|
    if i == 0
      array << 0
    elsif i ==1 
      array << 1
    else
      fib = array[i-1] + array[i - 2]
      array  << fib
    end
  end
  array
end

 pp fibs(5)

 def fibs_rec(num)
  return [0] if num == 0
  return [0, 1] if num == 1

  array = fibs_rec(num - 1)
  array << array[-2] + array[-1]
  end
 pp fibs_rec(5)


