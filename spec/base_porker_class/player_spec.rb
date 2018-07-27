require 'rspec'
require_relative '../../src/three_card_ver/three_card_porker_hand'
require_relative '../../src/base_porker_class/player'
require_relative '../../src/base_porker_class/card'

describe "Player" do
  describe "生成されたとき、自分の手札を持つ" do
    player = Player.new(ThreeCardPorkerHand.new([Card.new(Suit::Spade, CardRank::RankA[:rank], CardRank::RankA[:score]), Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]), Card.new(Suit::Diamond, CardRank::RankQ[:rank], CardRank::RankQ[:score])]))
    it "自分の手札ができる" do
      expect(player.hand).to be player.hand
      expect(player.hand).to be_an_instance_of(ThreeCardPorkerHand)
    end
  end
end
