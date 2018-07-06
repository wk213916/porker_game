require_relative "../base_porker_class/porker_hand.rb"
require_relative "../base_porker_class/hand.rb"
require_relative "three_card_porker_judge.rb"

class ThreeCardPorkerHand < Hand
  attr_reader :cards_orderd_rank, :cards_orderd_suit
  attr_accessor :role_score

  def initialize(first_card, second_card, third_card)
    @cards = []
    @cards << first_card << second_card << third_card
    @cards_orderd_rank = @cards.sort_by { |card| card.rank }
    @cards_orderd_suit = @cards.sort_by { |card| card.suit[:id] }
    @role_score = 0
  end

  def is_my_hand_all_same_rank_cards?
    @cards_orderd_rank[0].has_all_same_rank?(@cards_orderd_rank[1], @cards_orderd_rank[2])
  end

  def is_my_hand_all_same_suit_cards?
    @cards_orderd_suit[0].has_all_same_suit?(@cards_orderd_suit[1], @cards_orderd_suit[2])
  end

  def has_my_hand_same_rank_cards?
    @cards_orderd_rank[0].has_same_rank?(@cards_orderd_rank[1], @cards_orderd_rank[2])
  end

  def is_my_hand_all_series_cards?
    @cards_orderd_rank[0].is_series?(@cards_orderd_rank[1], @cards_orderd_rank[2])
  end

  # def initialize_card_ranks
  #   @card_ranks = @cards.sort_by!{ |card| card.rank }.reverse.map{ |card| card.rank }
  #   if @card_ranks[0] == RankPicture::A && @card_ranks[1] == 2 && @card_ranks[2] == 3
  #     @card_ranks = [3, 2, 1]
  #   end
  # end

end
