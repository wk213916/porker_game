require_relative "three_card_porker_hand.rb"

class Player
  attr_accessor :hand
  def initialize(player_hands)
    @hand = player_hands
  end
end
