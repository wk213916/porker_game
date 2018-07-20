class Hand
  attr_reader :cards, :cards_orderd_by_rank
  attr_accessor :role

  def initialize(hand_cards)
    @cards = hand_cards
    @cards_orderd_by_rank = @cards.sort_by { |card| card.rank }
    check_hand_role
  end

  def all_same_rank_cards?
    first_card = cards.first
    first_card.has_all_same_rank?(*cards)
  end

  def all_same_suit_cards?
    first_card = cards.first
    first_card.has_all_same_suit?(*cards)
  end

  def has_same_rank_cards?
    cards_orderd_by_rank.each do |card|
      cards_orderd_by_rank.each { |another_card| return true if card != another_card && card.rank == another_card.rank }
    end
    false
  end

  def all_series_cards?
    return true if judge_straight_A_as_14
    cards_orderd_by_rank.each_cons(2){ |cards| return false if cards[0].is_series?(cards[1]) == false }
    true
  end

  def judge_straight_A_as_14
    return false if cards_orderd_by_rank.first.rank != 1 || cards_orderd_by_rank.last.rank != 13
    cards_except_A = cards_orderd_by_rank.select{|card| card.rank != 1}
    cards_except_A.each_cons(2){ |cards| return false if cards[0].is_series?(cards[1]) == false }
    true
  end

  def check_hand_role
    raise NotImplementedEroor.new("このメソッドはオーバライドしないとエラーになります")
  end
end
