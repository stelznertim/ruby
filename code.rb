# where the codes used to play are created

require 'io/console'

class Code
  attr_accessor :code, :matching_pattern

  def initialize
    @code = []
    @matching_pattern = []
  end

  COLORS = %w[blue red yellow green pink violet].freeze


  def set_code(computer_code = nil)
    4.times do |i|
      if computer_code.nil?
        puts('Press 0 => blue, 1 => red, 2 => yellow, 3 =>green, 4 => pink and 5 => violet: ')
        puts "Select the #{i + 1}. color."
        code.push(COLORS[gets.chomp.to_i])
      else
        code.push(COLORS[computer_code[i]])
      end
    end
    code
  end

  def compare_code(secret_code)
    color_check(secret_code)
    4.times do |index|
      position_check(index, secret_code)
    end
    print 'You have a matching pattern that looks like this: '
    pp matching_pattern
    pp "Your input: #{code}"
    matching_pattern
  end

  def position_check(index, secret_code)
    if secret_code.code[index] == code[index]
      matching_pattern.pop
      matching_pattern.unshift('black')
    end
  end

  def color_check(secret_code)
    COLORS.each { |item| # .uniq auf guessing_code für kleinere schleife
      [code.count(item), secret_code.code.count(item)].min.times do
        matching_pattern.push('white')
      end
    }
  end

  def clear_cache
    matching_pattern.clear
    code.clear
  end

  def number_to_color(item)
    4.times do |index|
      item[index -1] = COLORS[item[index-1]]
    end
    item
  end

end

# vererbung von code klasse
class SecretCode < Code
  def set_code
    puts('Press 0 => blue, 1 => red, 2 => yellow, 3 => green, 4 => pink and 5 => violet: ')
    4.times do |i|
      puts "Select the #{i + 1}. color."
      code.push(COLORS[$stdin.noecho(&:gets).chomp.to_i])
    end
  end

  def set_random_code
    4.times do
      code.push(COLORS[rand(6)])
    end
  end
end
