class Computer
  attr_accessor :board, :word_index

  def self.compare_word(guess, word)
    matches = []
    @word_index = 0
    word.each_char { |char| matches = char == guess ? matching_index(matches, true) : matching_index(matches, false)}
    matches
  end

  def self.matching_index(matches, is_match)
    matches << @word_index unless is_match == false

    @word_index += 1
    matches
  end
end
