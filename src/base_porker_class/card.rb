require_relative "porker_hand.rb"

class Card
  attr_accessor :suit, :rank
  def initialize(suit,rank)
    @suit = suit
    @rank = rank
  end

  def notation
    "#{@rank}#{@suit}"
  end
end
