class Card
  attr_reader :suit, :rank
  def initialize(suit,rank)
    @suit = suit
    @rank = rank
  end

  def get_notation
    return "#{@rank}#{@suit}"
  end

  def has_same_suit(pair)
    return true if self.suit == pair.suit
  end

  def has_same_rank(pair)
    return true if self.rank == pair.rank
  end
end

first_card = Card.new("♡","3")
second_card = Card.new("♡", "8")
first_card.has_same_suit(second_card)
first_card.has_same_suit(second_card)
