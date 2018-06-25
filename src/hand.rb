require_relative "porker_hand.rb"
require_relative "card.rb"

class Hand
  attr_reader :cards
  #該当するオブジェクトの外部から、属性を書き換える必要があるので、accessorを用いる
  attr_accessor :porker_role, :winning
  def initialize(first_card, second_card)
    @cards = []
    @cards << first_card
    @cards << second_card
  end

  def judge_result(second_hand)
    if second_hand.porker_role[:hand_score] < @porker_role[:hand_score]
      @winning = GameResult::Win
      second_hand.winning = GameResult::Lose
    elsif second_hand.porker_role[:hand_score] > @porker_role[:hand_score]
      @winning = GameResult::Lose
      second_hand.winning = GameResult::Win
    else
      @winning = GameResult::Draw
      second_hand.winning = GameResult::Draw
    end
    @winning
  end
end

first_hand = Hand.new(Card.new("♤", 6), Card.new("♧", 7))
second_hand = Hand.new(Card.new("♤", RankPicture::A), Card.new("♧", RankPicture::A))

first_hand.porker_role = first_hand.cards[0].check_hand_card(first_hand.cards[1])
second_hand.porker_role = second_hand.cards[0].check_hand_card(second_hand.cards[1])

first_hand.judge_result(second_hand)
