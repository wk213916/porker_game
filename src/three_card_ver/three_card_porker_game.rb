require_relative "../base_porker_class/player.rb"
require_relative '../base_porker_class/deck.rb'
require_relative "../base_porker_class/judge.rb"
require_relative "three_card_porker_hand.rb"
require_relative "../base_porker_class/card.rb"

class Game
  attr_reader :player, :cpu, :judge

  def initialize(player, cpu)
    @player = player
    @cpu = cpu
    @judge = Judge.new(@player.hand, @cpu.hand)
  end

  def result
    judge.role_score_judge
  end
end

deck = Deck.new(hand_count: 3)
player = Player.new(ThreeCardPorkerHand.new([Card.new(Suit::Spade, RankPicture::A), Card.new(Suit::Diamond, RankPicture::Q), Card.new(Suit::Clover, RankPicture::K)]))
cpu = Player.new(ThreeCardPorkerHand.new(deck.deal_cards))
game = Game.new(player, cpu)
game.result
