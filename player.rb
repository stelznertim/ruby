# gives the player object structure and some additional user interaction
class Player
  attr_reader :name, :role

  def initialize(player_one_role = nil)
    @name = set_name
    @role = assign_role(player_one_role)
  end

  def set_name
    print 'Enter your name: '
    @name = gets.chomp
  end

  def assign_role(player_one_role)
    if player_one_role.nil?
      print('Enter 1 => Codemaker or 2 => Codebreaker: ')
      @role = gets.chomp.to_i == 1 ? 'codemaker' : 'codebreaker'
    else
      @role = player_one_role == 'codemaker' ? 'codebreaker' : 'codemaker'
    end
  end

  def announce_role
    puts(@role == 'codebreaker' ? "#{@name} you are the #{@role}" : "#{@name} you are the #{@role}.")
  end
end

class Computer < Player
  def initialize(player_one_role)
    @name = 'Computer'
    @role = assign_role(player_one_role)
  end
end
