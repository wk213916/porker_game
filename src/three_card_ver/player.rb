require_relative "hand.rb"

class Player
  attr_accessor :hand, :winning, :role_score
  def initialize(player_hands)
    @hand = player_hands
    @check_times = @hand.cards.length - 1
  end
end
