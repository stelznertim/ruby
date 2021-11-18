class Player
  attr_reader :name
  attr_accessor :guess

  def initialize
    @name = 'Tom'
    @guess = ''
  end

  def make_guess
    puts 'Enter the next character you want to guess: '
    gets.chomp
  end

  def load_name(name)
    @name = name
  end
end
