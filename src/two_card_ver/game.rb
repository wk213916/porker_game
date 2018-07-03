require_relative "porker_hand.rb"
require_relative "hand.rb"

class Game
  attr_accessor :hands
  def initialize(first_hand, second_hand)
    @hands = { player_hand: first_hand, cpu_hand: second_hand }
  end

  def judge_result
    if @hands[:cpu_hand].role[:score] == @hands[:player_hand].role[:score]
      @hands[:player_hand].draw_role_score_judge(@hands[:cpu_hand])
    else
      @hands[:player_hand].role_score_judge(@hands[:cpu_hand])
    end
  end
end
