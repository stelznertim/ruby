# gives the player object structure and some additional user interaction

class Player
  attr_accessor :name, :code, :role

  CODE_SIZE = 4
  COLORS = %w[blue red yellow green pink violet].freeze

  def initialize(role = nil)
    @name = set_name
    @role = assign_role(role)
    @code = assign_code_type
  end

  def set_name
    print 'Enter your name: '
    @name = gets.chomp
  end

  def assign_role(role)
    if role.nil?
      print('Enter 1 => Codemaker or 2 => Codebreaker: ')
      @role = gets.chomp.to_i == 1 ? 'codemaker' : 'codebreaker'
    else
      @role = role
    end
  end

  def assign_code_type
    @code = @role == 'codemaker' ? SecretCode.new : Code.new
  end

  def announce_role
    puts "#{@name} you are the #{@role}"
  end

  def set_code(computer_code = nil)
    if computer_code.nil?
      puts('Press 0 => blue, 1 => red, 2 => yellow, 3 =>green, 4 => pink and 5 => violet: ')
      if code.instance_of?(SecretCode)
        CODE_SIZE.times do |i|
          puts "Select the #{i + 1}. color."
          code.code.push(COLORS[$stdin.noecho(&:gets).chomp.to_i])
        end
      else
        CODE_SIZE.times do |i|
          puts "Select the #{i + 1}. color."
          code.code.push(COLORS[gets.chomp.to_i])
        end
      end
    else
      CODE_SIZE.times do |i|
        code.code.push(COLORS[computer_code[i]])
      end
    end
    code.code
  end

  def number_to_color(item)
    item.length.times do |index|
      item[index - 1] = COLORS[item[index - 1]]
    end
    item
  end
end

# children from Player with algorithm for finding guesses
class Computer < Player
  attr_accessor :combinationset, :patternset, :combinations

  def initialize(role)
    @name = 'Computer'
    @role = assign_role(role)
    @code = assign_code_type
  end

  def computer_codemaking
    set_random_code
  end

  def set_random_code
    CODE_SIZE.times do
      code.code.push(COLORS[rand(6)])
    end
    code.code
  end
end
