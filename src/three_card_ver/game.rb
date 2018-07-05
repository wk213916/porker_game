require_relative "porker_hand.rb"
require_relative "player.rb"
require_relative "judge.rb"
require_relative "hand.rb"

class Game
  attr_accessor :player, :cpu, :judge
  def initialize(player_hand, cpu_hand)
    @player = Player.new(player_hand)
    @cpu = Player.new(cpu_hand)
    @judge = Judge.new(@player, @cpu)
  end

  def judge_result
    if @player.role_score == @cpu.role_score
      @judge.draw_role_score_judge
    else
      @judge.role_score_judge
    end
  end
end

game = Game.new((Hand.new(Card.new(Suit::Spade, RankPicture::Q), Card.new(Suit::Clover, RankPicture::K))), (Hand.new(Card.new(Suit::Spade, 8), Card.new(Suit::Clover, 9))))
game.judge_result
