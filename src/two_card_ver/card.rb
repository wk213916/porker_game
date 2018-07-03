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

  def check_hand_card(card)
    if is_series?(card) && has_same_suit?(card)
      HandCombination::StraightFlash
    elsif has_same_rank?(card)
      HandCombination::Pair
    elsif is_series?(card)
      HandCombination::Straight
    elsif has_same_suit?(card)
      HandCombination::Flash
    else
      HandCombination::HighCard
    end
  end
end
