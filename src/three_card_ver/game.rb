require_relative "player.rb"
require_relative "three_card_porker_judge.rb"
require_relative "three_card_porker_hand.rb"
require_relative "three_card_porker_card.rb"

class Game
  attr_reader :player, :cpu, :judge
  def initialize(player_hand, cpu_hand)
    @player = Player.new(player_hand)
    @cpu = Player.new(cpu_hand)
    @judge = Judge.new(@player, @cpu)
  end

  def judge_result
    @player.hand.role_score = @judge.check_hand_role(@judge.player.hand)
    @cpu.hand.role_score = @judge.check_hand_role(@judge.cpu.hand)
    @judge.role_score_judge
    p @judge.player.hand.role_score
    p @judge.cpu.hand.role_score
    # if @player.hand.role_score == @cpu.hand.role_score
    #   @judge.draw_role_score_judge
    # else
    #   @judge.role_score_judge
    # end
  end
end

game = Game.new((ThreeCardPorkerHand.new(ThreeCardPorkerCard.new(Suit::Spade, RankPicture::Q), ThreeCardPorkerCard.new(Suit::Clover, RankPicture::K), ThreeCardPorkerCard.new(Suit::Clover, RankPicture::J))), (ThreeCardPorkerHand.new(ThreeCardPorkerCard.new(Suit::Spade, 8), ThreeCardPorkerCard.new(Suit::Clover, 9), ThreeCardPorkerCard.new(Suit::Clover, 8))))
game.judge_result
