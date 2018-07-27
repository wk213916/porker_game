require 'rspec'
require_relative '../../src/base_porker_class/porker_hand'
require_relative '../../src/base_porker_class/card'

describe "Card" do
  let(:hand) {ThreeCardPorkerHand.new([first_card, second_card, third_card])}

  describe "has_all_same_rank?メソッドの挙動" do
    context "3枚ともrankが同じである場合" do
      let(:first_card) {Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score])}
      let(:second_card) {Card.new(Suit::Diamond, CardRank::RankK[:rank], CardRank::RankK[:score])}
      let(:third_card) {Card.new(Suit::Heart, CardRank::RankK[:rank], CardRank::RankK[:score])}
      it "trueを返す" do
        expect(first_card.has_all_same_rank?(first_card, second_card, third_card)).to eq true
      end
    end
    context "1枚でも異なる場合" do
      let(:first_card) {Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score])}
      let(:second_card) {Card.new(Suit::Diamond, CardRank::RankK[:rank], CardRank::RankK[:score])}
      let(:third_card) {Card.new(Suit::Heart, CardRank::Rank10[:rank], CardRank::Rank10[:score])}
      it "falseを返す" do
        expect(first_card.has_all_same_rank?(second_card, third_card)).to eq false
      end
    end
  end
  describe "has_all_same_suit?メソッドの挙動" do
    context "3枚ともsuitが同じである場合" do
      let(:first_card) {Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score])}
      let(:second_card) {Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score])}
      let(:third_card) {Card.new(Suit::Spade, CardRank::Rank10[:rank], CardRank::Rank10[:score])}
      it "trueを返す" do
        expect(first_card.has_all_same_suit?(second_card, third_card)).to eq true
      end
    end
    context "1枚でも異なる場合" do
      let(:first_card) {Card.new(Suit::Heart, CardRank::Rank5[:rank], CardRank::Rank5[:score])}
      let(:second_card) {Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score])}
      let(:third_card) {Card.new(Suit::Spade, CardRank::Rank10[:rank], CardRank::Rank10[:score])}
      it "falseを返す" do
        expect(first_card.has_all_same_suit?(second_card, third_card)).to eq false
      end
    end
  end
  describe "is_series?メソッドの挙動" do
    context "右隣のカードのrankが1つ大きい場合" do
      let(:first_card) {Card.new(Suit::Heart, CardRank::Rank5[:rank], CardRank::Rank5[:score])}
      let(:second_card) {Card.new(Suit::Spade, CardRank::Rank6[:rank], CardRank::Rank6[:score])}
      let(:third_card) {Card.new(Suit::Spade, CardRank::Rank7[:rank], CardRank::Rank7[:score])}
      it "trueを返す" do
        expect(first_card.is_series?(second_card)).to eq true
        expect(second_card.is_series?(third_card)).to eq true
      end
    end
    context "1つ違いじゃない場合" do
      let(:first_card) {Card.new(Suit::Heart, CardRank::Rank2[:rank], CardRank::Rank2[:score])}
      let(:second_card) {Card.new(Suit::Spade, CardRank::Rank6[:rank], CardRank::Rank6[:score])}
      let(:third_card) {Card.new(Suit::Spade, CardRank::Rank4[:rank], CardRank::Rank4[:score])}
      it "falseを返す" do
        expect(first_card.is_series?(second_card)).to eq false
        expect(second_card.is_series?(third_card)).to eq false
      end
    end
  end
end
