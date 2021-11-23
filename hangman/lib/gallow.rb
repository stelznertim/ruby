class Gallow
  attr_accessor :gallow_appearance, :failure_count

  GALLOW_DESIGN = [
    %(    ___),
    %(    |___),
    %(    |
    |___),
    %(    |
    |
    |___),
    %(    |
    |
    |
    |___),
    %(    |
    |
    |
    |
    |___),
    %(     _____
    |
    |
    |
    |
    |___),
    %(     _____
    |     |
    |
    |
    |
    |___),
    %(     _____
    |     |
    |     O
    |
    |
    |___),
    %(     _____
    |     |
    |     O
    |    /|\\
    |
    |___),
    %(     _____
    |     |
    |     O
    |    /|\\ YOU HAVE BEEN HANGED ☠️  GAME OVER!
    |    / \\
    |___)
  ]

  def initialize
    @failure_count = 0
    @gallow_appearance = ''
  end

  def update_gallow
    @gallow_appearance = GALLOW_DESIGN[failure_count]
    @failure_count += 1
  end

  def hangman_completed?
    gallow_appearance == GALLOW_DESIGN[-1]
  end

  def load_gallow(gallow, failure_count)
    @gallow = gallow
    @failure_count = failure_count
  end
end
