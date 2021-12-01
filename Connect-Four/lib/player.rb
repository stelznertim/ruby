class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def select_column
    puts "#{name} please select a column: "
    gets.chomp.to_i
  end
end
