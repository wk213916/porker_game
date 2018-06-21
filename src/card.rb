require_relative "porker_hand.rb"

class Card
  attr_reader :suit, :rank
  def initialize(suit,rank)
    @suit = suit
    @rank = rank
  end

  def notation
    "#{@rank}#{@suit}"
  end

  def has_same_rank?(card)
    @rank == card.rank
  end

  def has_same_suit?(card)
    @suit == card.suit
  end

  def is_series?(card)
    return true if @rank == RankPicture::A && card.rank == RankPicture::K
    return true if @rank == RankPicture::K && card.rank == RankPicture::A
    @rank + 1 == card.rank || card.rank + 1 == @rank
  end

  def check_hand(card)
    if is_series?(card) && has_same_suit?(card)
      Hand::StraightFlash
    elsif has_same_rank?(card)
      Hand::Pair
    elsif is_series?(card)
      Hand::Straight
    elsif has_same_suit?(card)
      Hand::Flash
    else
      Hand::HighCard
    end
  end
end

# card = Card.new("♧", RankPicture::A)
# other_card = Card.new("♡", RankPicture::K)
# card.is_series?(other_card)
