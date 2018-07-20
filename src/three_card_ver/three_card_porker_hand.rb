require_relative "../base_porker_class/porker_hand.rb"
require_relative "../base_porker_class/hand.rb"
require_relative "../base_porker_class/judge.rb"

class ThreeCardPorkerHand < Hand

  def check_hand_role
    if all_series_cards? && all_same_suit_cards?
      @role = ThreeCardPorkerHandRole::StraightFlash
    elsif all_same_rank_cards?
      @role = ThreeCardPorkerHandRole::ThreeCard
    elsif all_series_cards?
      @role = ThreeCardPorkerHandRole::Straight
    elsif all_same_suit_cards?
      @role = ThreeCardPorkerHandRole::Flash
    elsif has_same_rank_cards?
      @role = ThreeCardPorkerHandRole::Pair
    else
      @role = ThreeCardPorkerHandRole::HighCard
    end
  end

end

# if cards_orderd_by_rank.last.rank == RankPicture::A
#   cards_orderd_by_rank.last.rank = RankPicture::A[:min]
#   cards_orderd_by_rank.each_cons(2){ |cards| return false if cards[0].is_series?(cards[1]) == false }
#   true

# def initialize_card_ranks
#   @card_ranks = @cards.sort_by!{ |card| card.rank }.reverse.map{ |card| card.rank }
#   if @card_ranks[0] == RankPicture::A && @card_ranks[1] == 2 && @card_ranks[2] == 3
#     @card_ranks = [3, 2, 1]
#   end
# end
