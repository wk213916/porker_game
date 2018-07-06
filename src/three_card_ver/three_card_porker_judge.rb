require_relative '../base_porker_class/porker_hand.rb'
require_relative 'player.rb'

class Judge
  attr_reader :player, :cpu
  attr_accessor :player_winning, :cpu_winning
  def initialize(player, cpu)
    @player = player
    @cpu = cpu
  end

  def check_hand_role(player_hand)
    if player_hand.is_my_hand_all_series_cards? && player_hand.is_my_hand_all_same_suit_cards?
      ThreeCardPorkerHandRole::StraightFlash
    elsif player_hand.is_my_hand_all_same_rank_cards?
      ThreeCardPorkerHandRole::ThreeCard
    elsif player_hand.is_my_hand_all_series_cards?
      ThreeCardPorkerHandRole::Straight
    elsif player_hand.is_my_hand_all_same_suit_cards?
      ThreeCardPorkerHandRole::Flash
    elsif player_hand.has_my_hand_same_rank_cards?
      ThreeCardPorkerHandRole::Pair
    else
      ThreeCardPorkerHandRole::HighCard
    end
  end

  def role_score_judge
    if @cpu.hand.role_score < @player.hand.role_score
      @player_winning = GameResult::Win
      @cpu_winning = GameResult::Lose
    elsif @cpu.hand.role_score > @player.hand.role_score
      @player_winning = GameResult::Lose
      @cpu_winning = GameResult::Win
    else
      @player_winning = GameResult::Unknown
      @cpu_winning = GameResult::Unknown
    end
  end

  # def draw_role_score_judge
  #   straight_category_scores = [ThreeCardPorkerHandRole::Straight[:score],ThreeCardPorkerHandRole::StraightFlash[:score]]
  #   if straight_category_scores.include?(@player.hand.role_score)
  #     straight_category_result_judge
  #   else
  #     other_category_result_judge
  #   end
  # end
# private
#   def straight_category_result_judge
#     cpu_hand_scores = @cpu.hand.card_ranks.inject(0) { |sum, card_rank| sum += card_rank }
#     player_hand_scores = @player.hand.card_ranks.inject(0) { |sum, card_rank| sum += card_rank }
#     if cpu_hand_scores < player_hand_scores
#       @player_winning = GameResult::Win
#       @cpu_winning = GameResult::Lose
#     elsif cpu_hand_scores > player_hand_scores
#       @player_winning = GameResult::Lose
#       @cpu_winning = GameResult::Win
#     else
#       @player_winning = GameResult::Draw
#       @cpu_winning = GameResult::Draw
#     end
#   end
#
#   def other_category_result_judge
#     @player.hand.card_ranks.each_with_index do |player_card_rank, i|
#       if @cpu.hand.card_ranks[i] < player_card_rank
#         @player_winning = GameResult::Win
#         @cpu_winning = GameResult::Lose
#         break
#       elsif @cpu.hand.card_ranks[i] > player_card_rank
#         @player_winning = GameResult::Lose
#         @cpu_winning = GameResult::Win
#         break
#       else
#         @winning = GameResult::Draw
#         @cpu_winning = GameResult::Draw
#       end
#     end
#   end
end
