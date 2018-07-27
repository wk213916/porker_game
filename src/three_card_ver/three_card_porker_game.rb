require_relative "../base_porker_class/player.rb"
require_relative '../base_porker_class/deck.rb'
require_relative "three_card_porker_judge.rb"
require_relative "three_card_porker_hand.rb"
require_relative "../base_porker_class/card.rb"

class Game
  attr_reader :player, :cpu, :judge

  def initialize(player, cpu)
    @player = player
    @cpu = cpu
    @judge = ThreeCardPorkerJudge.new(@player.hand, @cpu.hand)
  end

  def result
    judge.role_score_judge
  end
end

deck = Deck.new(hand_count: 3)
player = Player.new(ThreeCardPorkerHand.new([Card.new(Suit::Spade, CardRank::RankA[:rank], CardRank::RankA[:score]), Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]), Card.new(Suit::Diamond, CardRank::RankQ[:rank], CardRank::RankQ[:score])]))
cpu = Player.new(ThreeCardPorkerHand.new([Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]), Card.new(Suit::Clover, CardRank::RankQ[:rank], CardRank::RankQ[:score]), Card.new(Suit::Heart, CardRank::RankA[:rank], CardRank::RankA[:score])]))
game = Game.new(player, cpu)
game.result
