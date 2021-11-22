class Output

  def self.game_start(name, word_length)
    puts "G'day Sir #{name}.\nThe length of the word you search for is #{word_length} characters long.\nMay the force be with you! "
  end

  def self.winner_announcement(name)
    puts "Congratz #{name} you successfully escaped your own execution! You are now officially a Jedi!"
  end

  def self.loser_announcement(word)
    puts "Git gud son. The word you searched for is #{word}. I would suggest you take another try but since u are not under the living anymore thats not possible. May God have mercy for your soul, young padawan."
  end

  def self.load
    puts 'Do you want to load a save? Enter yes or no: '
  end

  def self.save
    puts 'Do you want to save the game? Enter yes or no: '
  end
end
