require_relative "porker_hand.rb"
require_relative "card.rb"

class Hand
  attr_reader :cards
  #該当するオブジェクトの外部から、属性を書き換える必要があるので、accessorを用いる
  attr_accessor :role, :winning, :card_scores
  def initialize(first_card, second_card)
    @cards = []
    @cards << first_card
    @cards << second_card
    self.set_hand_role
    self.set_card_scores
  end

  def set_hand_role
    @role = self.cards[0].check_hand_card(self.cards[1])
  end

  def set_card_scores
    @card_scores = @cards.sort_by!{|card| card.rank}.reverse.map{|card| card.rank}
  end

# ハイカード、フラッシュの場合、一応ペアも可能
  def card_score_judge(second_hand)
    @card_scores.each_with_index do |card_score, i|
      if second_hand.card_scores[i] < card_score
        @winning = GameResult::Win
        second_hand.winning = GameResult::Lose
      elsif second_hand.card_scores[i] > card_score
        @winning = GameResult::Lose
        second_hand.winning = GameResult::Win
      else
        @winning = GameResult::Draw
        second_hand.winning = GameResult::Draw
      end
    end
  end

# ストレート、ストレートフラッシュの場合、ペアも可能
  def card_score_judge_straight(second_hand)
    if second_hand.card_scores.inject(0) {|sum, card_score| sum += card_score} < @card_scores.inject(0) {|sum, card_score| sum += card_score}
      @winning = GameResult::Win
      second_hand.winning = GameResult::Lose
    elsif second_hand.card_scores.inject(0) {|sum, card_score| sum += card_score} > @card_scores.inject(0) {|sum, card_score| sum += card_score}
      @winning = GameResult::Lose
      second_hand.winning = GameResult::Win
    else
      @winning = GameResult::Draw
      second_hand.winning = GameResult::Draw
    end
  end

end
