class Card
  attr_reader :suit, :rank
  def initialize(suit,rank)
    @suit = suit
    @rank = rank
  end

  def get_notation
    "#{@rank}#{@suit}"
  end

  def has_same_suit?(card)
    self.suit == card.suit
  end

  def has_same_rank?(card)
    self.rank == card.rank
  end
end
