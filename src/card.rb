require_relative "porker_hand.rb"

class Card
  attr_reader :suit, :rank
  def initialize(suit,rank)
    @suit = suit
    @rank = rank
  end

  def get_notation
    "#{@rank}#{@suit}"
  end

  def has_same_rank?(card)
    self.rank == card.rank
  end

  def has_same_suit?(card)
    self.suit == card.suit
  end

  def check_hand(card)
    if has_same_rank?(card)
      Hand::Pair
    elsif has_same_suit?(card)
      Hand::Flash
    else
      Hand::HighCard
    end
  end
end

♧three = Card.new("♧", 3)
♧four = Card.new("♧", 4)

♧three.check_hand(♧four)
