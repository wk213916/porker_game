require_relative "porker_hand.rb"
require_relative "player.rb"
require_relative "card.rb"

class Hand
  attr_reader :cards
  attr_accessor :role, :winning, :card_ranks
  def initialize(first_card, second_card)
    @cards = []
    @cards << first_card
    @cards << second_card
    self.initialize_hand_role
    self.initialize_card_ranks
  end

  def initialize_hand_role
    @role = @cards[0].check_hand_card(@cards[1])
  end

  def initialize_card_ranks
    @card_ranks = @cards.sort_by!{ |card| card.rank }.reverse.map{ |card| card.rank }
    if @card_ranks[0] == RankPicture::A && @card_ranks[1] == 2
      @card_ranks = [2, 1]
    end
  end

  def draw_role_score_judge(cpu_hand)
    straight_category_scores = [HandCombination::Straight[:score],HandCombination::StraightFlash[:score]]
    if straight_category_scores.include?(@role[:score])
      straight_category_result_judge(cpu_hand)
    else
      other_category_result_judge(cpu_hand)
    end
  end

  def role_score_judge(cpu_hand)
    if cpu_hand.role[:score] < @role[:score]
      @winning = GameResult::Win
      cpu_hand.winning = GameResult::Lose
    elsif cpu_hand.role[:score] > @role[:score]
      @winning = GameResult::Lose
      cpu_hand.winning = GameResult::Win
    else
      @winning = GameResult::Unknown
      cpu_hand.winning = GameResult::Unknown
    end
  end

private
  def straight_category_result_judge(cpu_hand)
    cpu_hand_scores = cpu_hand.card_ranks.inject(0) { |sum, card_rank| sum += card_rank }
    player_hand_scores = @card_ranks.inject(0) { |sum, card_rank| sum += card_rank }
    if cpu_hand_scores < player_hand_scores
      @winning = GameResult::Win
      cpu_hand.winning = GameResult::Lose
    elsif cpu_hand_scores > player_hand_scores
      @winning = GameResult::Lose
      cpu_hand.winning = GameResult::Win
    else
      @winning = GameResult::Draw
      cpu_hand.winning = GameResult::Draw
    end
  end

  def other_category_result_judge(cpu_hand)
    @card_ranks.each_with_index do |player_card_score, i|
      if cpu_hand.card_ranks[i] < player_card_score
        @winning = GameResult::Win
        cpu_hand.winning = GameResult::Lose
        break
      elsif cpu_hand.card_ranks[i] > player_card_score
        @winning = GameResult::Lose
        cpu_hand.winning = GameResult::Win
        break
      else
        @winning = GameResult::Draw
        cpu_hand.winning = GameResult::Draw
      end
    end
  end
end
