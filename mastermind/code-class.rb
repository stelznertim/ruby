# where the codes used to play are created

require 'io/console'

class Code
  attr_accessor :code, :matching_pattern

  def initialize
    @code = []
  end

  COLORS = %w[blue red yellow green pink violet].freeze

  def clear_cache
    matching_pattern.clear
    code.clear
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
   
  end
end
