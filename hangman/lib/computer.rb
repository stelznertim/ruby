class Computer
  def self.compare_word(guess, word)
    matches = []
    @word_index = 0
    word.each_char { |char| matches = matching_index(matches, char == guess) }
    matches
  end

  def self.matching_index(matches, is_match)
    matches << @word_index unless is_match == false

    @word_index += 1
    matches
  end
end
