require_relative "porker_hand.rb"
require_relative "hand.rb"

class Game
  attr_accessor :hands
  def initialize(first_hand, second_hand)
    @hands = {player_hand: first_hand, cpu_hand: second_hand}
  end

  def judge_result
    if @hands[:cpu_hand].role[:score] < @hands[:player_hand].role[:score]
      @hands[:player_hand].winning = GameResult::Win
      @hands[:cpu_hand].winning = GameResult::Lose
    elsif @hands[:cpu_hand].role[:score] > @hands[:player_hand].role[:score]
      @hands[:player_hand].winning = GameResult::Lose
      @hands[:cpu_hand].winning = GameResult::Win
    else
      @hands[:player_hand].card_score_judge(@hands[:cpu_hand]) if @hands[:player_hand].role[:score] && @hands[:cpu_hand].role[:score] == 0 || 1 || 3
      @hands[:player_hand].card_score_judge_straight(@hands[:cpu_hand]) if @hands[:player_hand].role[:score] && @hands[:cpu_hand].role[:score] == 2 || 4
    end
    @winning
  end
end

game = Game.new(Hand.new(Card.new("♤", RankPicture::Q), Card.new("♧", RankPicture::K)), Hand.new(Card.new("♤", 8), Card.new("♧", 9)))
game.judge_result
