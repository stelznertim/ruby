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
    gallow.show_gallow
    puts word.dash_row_to_s
    puts ''
  end

  def update(guess, indexes)
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
