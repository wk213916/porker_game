require_relative "card.rb"

class Player
  attr_accessor :hand
  def initialize(hand)
    @hand = hand
  end
end
