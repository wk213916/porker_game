require 'rspec'
require_relative '../../src/base_porker_class/card'
require_relative '../../src/three_card_ver/three_card_porker_hand'

describe "ThreeCardPorkerHand" do
  let(:hand) do
    ThreeCardPorkerHand.new(
      [first_card, second_card, third_card]
    )
  end
  let(:first_card) {nil}
  let(:second_card) {nil}
  let(:third_card) {nil}
  describe "必要な値が入っているかのチェック" do
    let(:first_card) { Card.new(Suit::Spade, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
    let(:second_card) { Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]) }
    let(:third_card) { Card.new(Suit::Clover, CardRank::RankJ[:rank], CardRank::RankJ[:scpre]) }
    it "@cardsの値" do
      expect(hand.cards).to eq hand.cards
    end
    it "@cards_orderd_rankの値" do
      expect(hand.cards_orderd_by_rank).to eq hand.cards_orderd_by_rank
    end
  end
  describe "all_same_rank_cards?メソッドの挙動" do
    context "3枚の手札のランクが全て同じだった場合" do
      let(:first_card) { Card.new(Suit::Spade, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
      let(:second_card) { Card.new(Suit::Clover, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
      let(:third_card) { Card.new(Suit::Heart, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
      it "trueを返す" do
        expect(hand.all_same_rank_cards?).to eq true
      end
    end
    context "１枚でも異なる場合" do
      let(:first_card) { Card.new(Suit::Spade, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
      let(:second_card) { Card.new(Suit::Clover, CardRank::Rank9[:rank], CardRank::Rank9[:score]) }
      let(:third_card) { Card.new(Suit::Heart, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
      it "falseを返す" do
        expect(hand.all_same_rank_cards?).to eq false
      end
    end
  end
  describe "has_same_rank_cards?メソッドの挙動" do
    context "3枚の手札の内、2枚だけランクが同じだった場合" do
      let(:first_card) { Card.new(Suit::Spade, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
      let(:second_card) { Card.new(Suit::Clover, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
      let(:third_card) { Card.new(Suit::Heart, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
      it "trueを返す" do
        expect(hand.has_same_rank_cards?).to eq true
      end
    end
    context "3枚の手札のランクが全て異なった場合" do
      let(:first_card) { Card.new(Suit::Spade, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
      let(:second_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
      let(:third_card) { Card.new(Suit::Heart, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
      it "falseを返す" do
        expect(hand.all_same_suit_cards?).to eq false
        expect(hand.has_same_rank_cards?).to eq false
      end
    end
  end
  describe "all_series_cardsメソッドの挙動" do
    context "3枚の手札のランクが1つ違いで繋がっていた場合" do
      let(:first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
      let(:second_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
      let(:third_card) { Card.new(Suit::Heart, CardRank::Rank4[:rank], CardRank::Rank4[:score]) }
      it "trueを返す" do
        expect(hand.all_series_cards?).to eq true
      end
    end
    context "Q-K-Aの並びの場合" do
      let(:first_card) { Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score]) }
      let(:second_card) { Card.new(Suit::Clover, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
      let(:third_card) { Card.new(Suit::Heart, CardRank::RankA[:rank], CardRank::RankA[:score]) }
      it "trueを返す" do
        expect(hand.all_series_cards?).to eq true
      end
    end
    context "A-2-3の並びの場合" do
      let(:first_card) { Card.new(Suit::Spade, CardRank::Rank2[:rank], CardRank::Rank2[:score]) }
      let(:second_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
      let(:third_card) { Card.new(Suit::Heart, CardRank::RankA[:rank], CardRank::RankA[:score]) }
      it "trueを返す" do
        expect(hand.all_series_cards?).to eq true
      end
    end
    context "K-A-2の並びの場合" do
      let(:first_card) { Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score]) }
      let(:second_card) { Card.new(Suit::Clover, CardRank::Rank2[:rank], CardRank::Rank2[:score]) }
      let(:third_card) { Card.new(Suit::Heart, CardRank::RankA[:rank], CardRank::RankA[:score]) }
      it "falseを返す" do
        expect(hand.all_series_cards?).to eq false
      end
    end
  end
  describe "どの役にも当てはまらない時" do

  end
end
