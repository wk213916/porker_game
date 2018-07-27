class Hand
  attr_reader :cards, :cards_orderd_by_rank, :cards_orderd_by_score
  attr_accessor :role

  def initialize(hand_cards)
    @cards = hand_cards
    @cards_orderd_by_rank = @cards.sort_by { |card| card.rank }
    @cards_orderd_by_score = @cards.sort_by { |card| card.score }.reverse
    check_hand_role
  end

  def check_hand_role
    raise NotImplementedEroor.new("このメソッドはオーバライドしないとエラーになります")
  end

  def card_ranks
    @card_ranks ||= cards_orderd_by_rank.map { |card| card.rank }
  end

  def paird_card_scores
    card_scores.select{ |paird_card_score| card_scores.count(paird_card_score) >= 2 }.uniq!
  end

  def card_scores
    @card_scores ||= cards_orderd_by_score.map { |card| card.score }
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
    return true if judge_straight_A_as_1?
    cards_orderd_by_rank.each_cons(2){ |cards| return false if cards[0].is_series?(cards[1]) == false }
    true
  end

  def judge_straight_A_as_1?
    return false if cards_orderd_by_rank.first.rank != 1 || cards_orderd_by_rank.last.rank != 13
    cards_except_A = cards_orderd_by_rank.select{|card| card.rank != 1}
    cards_except_A.each_cons(2){ |cards| return false if cards[0].is_series?(cards[1]) == false }
    true
  end

  def weakest_straight?
    return true if card_ranks.first == 1 && card_ranks.last == card_ranks.length
    false
  end
# ストレートの強さを手札の数を参照して、定義していることに違和感

end
