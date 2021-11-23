class Board
  require_relative 'gallow'
  require_relative 'word'

  attr_accessor :word, :gallow, :used_letters

  def initialize
    @word = Word.new
    @gallow = Gallow.new
    @used_letters = []
  end

  def show
    print 'Already used letters: '
    pp used_letters
    puts gallow_to_s
    puts dash_row_to_s
    puts ''
  end

  def dash_row_to_s
    puts word.dash_row.join
  end

  def gallow_to_s
    puts gallow.gallow_appearance
  end

  def update(guess)
    indexes = word.compare_guess_to_word(guess)
    bad_guess?(indexes) ? gallow.update_gallow : word.update_dash_row(guess, indexes)
    used_letters << guess
    show
  end

  def bad_guess?(indexes)
    indexes.length.zero?
  end

  def load_used_letters(used_letters)
    @used_letters = used_letters
  end
end
