class Player
  attr_reader :name, :disc

  def initialize(name, symbol)
    @name = name
    @disc = symbol
  end

  def select_column
    puts 'Select a column: '
    gets.chomp.to_i
  end
end
