require 'rspec'
require_relative '../../src/base_porker_class/deck'
require_relative '../../src/base_porker_class/porker_hand'
require_relative '../../src/base_porker_class/card'

describe "Deck" do
  describe "生成された時に必要な値を持つ" do
    deck = Deck.new(hand_count: 3)
    it "52枚のカードを持つ" do
      expect(deck.deck_cards).to be deck.deck_cards
      expect(deck.deck_cards.length).to eq 52
    end
  end
  describe "build_deck!メソッドの挙動" do
    deck = Deck.new(hand_count: 3)
    dealed_card = deck.deal_cards[0]
    it "引いたカードがトランプのカードかどうか" do
      expect(dealed_card).to be_an_instance_of(Card)
    end
    it "引いたカードがデッキに残ってないかどうか" do
      expect(dealed_card).not_to contain_exactly deck.deck_cards
    end
  end
  describe "デッキーのカードがない状態でカードを引こうとした時" do
    context "TwoCardPorkerの場合" do
      deck = Deck.new(hand_count: 2)
      26.times { deck.deal_cards }
      it "27回以上手札を配ると、errorを出す" do
        expect{deck.deal_cards}.to raise_error(NoCardsError)
      end
    end
    context "ThreeCardPorkerの場合" do
      deck = Deck.new(hand_count: 3)
      17.times { deck.deal_cards }
      it "18回以上手札を配ると、errorを出す" do
        expect{deck.deal_cards}.to raise_error(NoCardsError)
      end
    end
    context "FiveCardPorkerの場合" do
      deck = Deck.new(hand_count: 5)
      10.times { deck.deal_cards }
      it "11回以上手札を配ると、errorを出す" do
        expect{deck.deal_cards}.to raise_error(NoCardsError)
      end
    end
  end
end
