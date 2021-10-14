class Codebreaker
  # colorset = %w[blue, blue, blue, blue, yellow, yellow, yellow, yellow, red, red, red, red, green, green, green, green, pink, pink, pink, pink, violet, violet, violet, violet].combination(4).to_a
  # puts colorset.length
  colorset = [['blue', 'red', 'yellow' , 'green', 'pink', 'violet'],['blue', 'red', 'yellow' ,' green',' pink', 'violet'],['blue', 'red', 'yellow', 'green', 'pink', 'violet'],['blue', 'red', 'yellow', 'green', 'pink', 'violet']]
  
  pp  s[0].product(*s[1..-1]).length
end

codebreaker = Codebreaker.new