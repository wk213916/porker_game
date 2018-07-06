require_relative "../base_porker_class/card.rb"

class ThreeCardPorkerCard < Card

  def has_all_same_rank?(*orderd_rank_cards)
    orderd_rank_cards.all? { |card| @rank == card.rank }
    # @rank == orderd_rank_cards[0].rank && orderd_rank_cards[0].rank == orderd_rank_cards[1].rank
  end

  def has_all_same_suit?(*orderd_suit_cards)
    orderd_suit_cards.all? { |card| @suit == card.suit }
    # @suit == orderd_suit_cards[0].suit && orderd_suit_cards[0].suit == orderd_suit_cards[1].suit
  end

  def has_same_rank?(*orderd_rank_cards)
    orderd_rank_cards.any? { |card| @rank == card.rank || orderd_rank_cards[0] == card.rank }
  end

  def is_series?(*orderd_rank_cards)
    # return true if @rank == RankPicture::Q && second_card.rank == RankPicture::K && third_card.rank == RankPicture::A
    @rank + 1 == orderd_rank_cards[0].rank && orderd_rank_cards[0].rank + 1 == orderd_rank_cards[1].rank
  end

end
