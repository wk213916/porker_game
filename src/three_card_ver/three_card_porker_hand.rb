require_relative "../base_porker_class/porker_hand.rb"
require_relative "../base_porker_class/hand.rb"
require_relative "../base_porker_class/judge.rb"

class ThreeCardPorkerHand < Hand

# パーフェクトRuby p.72、参照にして書き直す代入if
  def check_hand_role
    @role = if all_series_cards? && all_same_suit_cards?
              ThreeCardPorkerHandRole::StraightFlash
            elsif all_same_rank_cards?
              ThreeCardPorkerHandRole::ThreeCard
            elsif all_series_cards?
              ThreeCardPorkerHandRole::Straight
            elsif all_same_suit_cards?
              ThreeCardPorkerHandRole::Flash
            elsif has_same_rank_cards?
              ThreeCardPorkerHandRole::Pair
            else
              ThreeCardPorkerHandRole::HighCard
            end
  end

end
