require_relative "porker_hand.rb"

class Card
  attr_reader :suit, :rank
  def initialize(suit,rank)
    @suit = suit
    @rank = rank
  end

  def notation
    "#{rank}#{suit}"
  end

  def has_all_same_rank?(*cards)
    cards.all? { |card| rank == card.rank }
  end

  def has_all_same_suit?(*cards)
    cards.all? { |card| suit == card.suit }
  end

  def is_series?(next_card)
    rank + 1 == next_card.rank
  end
end
