class Gallow
  attr_accessor :gallow, :failure_count

  GALLOW_DESIGN = [
    %{    ___},
    %{    |___},
    %{    |
    |___},
    %{    |
    |
    |___},
    %{    |
    |
    |
    |___},
    %{    |
    |
    |
    |
    |___},
    %{     _____
    |     
    |
    |
    |
    |___},
    %{     _____
    |     |
    |
    |
    |
    |___},
    %{     _____
    |     |
    |     O
    |
    |
    |___},
    %{     _____
    |     |
    |     O
    |    /|\\
    |
    |___},
    %{     _____
    |     |
    |     O
    |    /|\\ YOU HAVE BEEN HANGED ☠️  GAME OVER!
    |    / \\
    |___}]

  def initialize
    @failure_count = 0
    @gallow = ''
  end

  def show_gallow
    puts gallow
  end

  def update_gallow
    @gallow = GALLOW_DESIGN[failure_count]
    @failure_count += 1
  end

  def hangman_completed?
    gallow == GALLOW_DESIGN[-1]
  end

  def load_gallow(gallow, failure_count)
    @gallow = gallow
    @failure_count = failure_count
  end
end
