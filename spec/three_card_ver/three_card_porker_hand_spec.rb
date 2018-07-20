require 'rspec'
require_relative '../../src/base_porker_class/porker_hand'
require_relative '../../src/base_porker_class/card'
require_relative '../../src/three_card_ver/three_card_porker_hand'

describe "ThreeCardPorkerHand" do
  let(:hand) do
    ThreeCardPorkerHand.new(
      first_card, second_card, third_card
    )
  end
  let(:first_card) {nil}
  let(:second_card) {nil}
  let(:third_card) {nil}
  describe "必要な値が入っているかのチェック" do
    let(:first_card) { Card.new(Suit::Spade, RankPicture::Q) }
    let(:second_card) { Card.new(Suit::Clover, RankPicture::K) }
    let(:third_card) { Card.new(Suit::Clover, RankPicture::J) }
    it "@cardsの値" do
      expect(hand.cards).to be hand.cards
    end
    it "@cards_orderd_rankの値" do
      expect(hand.cards_orderd_by_rank).to be hand.cards_orderd_by_rank
    end
  end
  describe "all_same_rank_cards?メソッドの挙動" do
    context "3枚の手札のランクが全て同じだった場合" do
      let(:first_card) { Card.new(Suit::Spade, RankPicture::Q) }
      let(:second_card) { Card.new(Suit::Clover, RankPicture::Q) }
      let(:third_card) { Card.new(Suit::Heart, RankPicture::Q) }
      it "trueを返す" do
        expect(hand.all_same_rank_cards?).to eq true
      end
    end
    context "１枚でも異なる場合" do
      let(:first_card) { Card.new(Suit::Spade, RankPicture::Q) }
      let(:second_card) { Card.new(Suit::Clover, 9) }
      let(:third_card) { Card.new(Suit::Heart, RankPicture::Q) }
      it "falseを返す" do
        expect(hand.all_same_rank_cards?).to eq false
      end
    end
  end
  describe "has_same_rank_cards?メソッドの挙動" do
    context "3枚の手札の内、2枚だけランクが同じだった場合" do
      let(:first_card) { Card.new(Suit::Spade, RankPicture::Q) }
      let(:second_card) { Card.new(Suit::Clover, RankPicture::Q) }
      let(:third_card) { Card.new(Suit::Heart, 7) }
      it "trueを返す" do
        expect(hand.has_same_rank_cards?).to eq true
      end
    end
    context "3枚の手札のランクが全て異なった場合" do
      let(:first_card) { Card.new(Suit::Spade, RankPicture::Q) }
      let(:second_card) { Card.new(Suit::Clover, 3) }
      let(:third_card) { Card.new(Suit::Heart, 7) }
      it "falseを返す" do
        expect(hand.all_same_suit_cards?).to eq false
        expect(hand.has_same_rank_cards?).to eq false
      end
    end
  end
  describe "all_series_cardsメソッドの挙動" do
    context "3枚の手札のランクが1つ違いで繋がっていた場合" do
      let(:first_card) { Card.new(Suit::Spade, 5) }
      let(:second_card) { Card.new(Suit::Clover, 3) }
      let(:third_card) { Card.new(Suit::Heart, 4) }
      it "trueを返す" do
        expect(hand.all_series_cards?).to eq true
      end
    end
    context "Q-K-Aの並びの場合" do
      let(:first_card) { Card.new(Suit::Spade, RankPicture::K) }
      let(:second_card) { Card.new(Suit::Clover, RankPicture::Q) }
      let(:third_card) { Card.new(Suit::Heart, RankPicture::A) }
      it "trueを返す" do
        expect(hand.all_series_cards?).to eq true
      end
    end
    context "A-2-3の並びの場合" do
      let(:first_card) { Card.new(Suit::Spade, 2) }
      let(:second_card) { Card.new(Suit::Clover, 3) }
      let(:third_card) { Card.new(Suit::Heart, RankPicture::A) }
      it "trueを返す" do
        expect(hand.all_series_cards?).to eq true
      end
    end
    context "K-A-2の並びの場合" do
      let(:first_card) { Card.new(Suit::Spade, RankPicture::K) }
      let(:second_card) { Card.new(Suit::Clover, 2) }
      let(:third_card) { Card.new(Suit::Heart, RankPicture::A) }
      it "falseを返す" do
        expect(hand.all_series_cards?).to eq false
      end
    end
  end
  describe "どの役にも当てはまらない時" do

  end
end
