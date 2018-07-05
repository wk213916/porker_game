require_relative "porker_hand.rb"
require_relative "card.rb"

class Hand
  attr_reader :cards
  attr_accessor :card_ranks, :role_score

  def initialize(first_card, second_card)
    @cards = []
    @cards << first_card
    @cards << second_card
    self.initialize_card_ranks
    @role_score = @cards[0].check_hand_card(@cards[1])[:score]
  end

  def initialize_card_ranks
    @card_ranks = @cards.sort_by!{ |card| card.rank }.reverse.map{ |card| card.rank }
    if @card_ranks[0] == RankPicture::A && @card_ranks[1] == 2
      @card_ranks = [2, 1]
    end
  end

  # def is_same_card_suits
  #   @check_times.times do |num|
  #     if @cards[num].has_same_suit?(@cards[num + 1])
  #       p @cards[num].suit
  #     end
  #   end
  #   p same_suits_count
  # end

  # def is_card_series_role?
  #   series_pair_count = 0
  #   @check_times.times do |num|
  #     if @cards[num].is_series?(@cards[num + 1])
  #       series_pair_count += 1
  #     end
  #     true if series_pair_count == @check_times
  #     false if series_pair_count != @check_times
  #   end
  # end

  # def check_hand_role
  #   if is_series?(card) && has_same_suit?(card)
  #     HandCombination::StraightFlash
  #   elsif has_same_rank?(card)
  #     HandCombination::Pair
  #   elsif is_card_series_role?
  #     HandCombination::Straight
  #   elsif has_same_suit?(card)
  #     HandCombination::Flash
  #   else
  #     HandCombination::HighCard
  #   end
  # end

end

hand = Hand.new(Card.new(Suit::Spade, RankPicture::Q), Card.new(Suit::Clover, RankPicture::K))
