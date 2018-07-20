require 'rspec'
require_relative '../../src/base_porker_class/porker_hand'
require_relative '../../src/base_porker_class/card'

describe "Card" do
  let(:first_card) {Card.new(first_card_suit, first_card_rank)}
  let(:first_card_suit) {nil}
  let(:first_card_rank) {nil}

  let(:second_card) {Card.new(second_card_suit, second_card_rank)}
  let(:second_card_suit) {nil}
  let(:second_card_rank) {nil}

  let(:third_card) {Card.new(third_card_suit, third_card_rank)}

  let(:third_card_suit) {nil}
  let(:third_card_rank) {nil}

  describe "has_all_same_rank?メソッドの挙動" do
    context "3枚ともrankが同じである場合" do
      let(:first_card_suit) { Suit::Spade }
      let(:second_card_suit) { Suit::Diamond }
      let(:third_card_suit) { Suit::Clover }
      let(:first_card_rank) { 10 }
      let(:second_card_rank) { 10 }
      let(:third_card_rank) { 10 }
      it "trueを返す" do
        expect(first_card.has_all_same_rank?(*second_card, third_card)).to eq true
      end
    end
    context "1枚でも異なる場合" do
      let(:first_card_suit) {Suit::Spade}
      let(:second_card_suit) {Suit::Heart}
      let(:third_card_suit) {Suit::Clover}
      let(:first_card_rank) { 5 }
      let(:second_card_rank) { 10 }
      let(:third_card_rank) { 10 }
      it "falseを返す" do
        expect(first_card.has_all_same_rank?(*second_card, third_card)).to eq false
      end
    end
  end
  describe "has_all_same_suit?メソッドの挙動" do
    context "3枚ともsuitが同じである場合" do
    let(:first_card_suit) { Suit::Spade }
    let(:second_card_suit) { Suit::Spade }
    let(:third_card_suit) { Suit::Spade }
    let(:first_card_rank) { 5 }
    let(:second_card_rank) { 6 }
    let(:third_card_rank) { 7 }
      it "trueを返す" do
        expect(first_card.has_all_same_suit?(*second_card, third_card)).to eq true
      end
    end
    context "1枚でも異なる場合" do
      let(:first_card_suit) { Suit::Diamond }
      let(:second_card_suit) { Suit::Spade }
      let(:third_card_suit) { Suit::Spade }
      let(:first_card_rank) { 5 }
      let(:second_card_rank) { 6 }
      let(:third_card_rank) { 7 }
      it "falseを返す" do
        expect(first_card.has_all_same_suit?(*second_card, third_card)).to eq false
      end
    end
  end
  describe "is_series?メソッドの挙動" do
    context "右隣のカードのrankが1つ大きい場合" do
      let(:first_card_suit) { Suit::Diamond }
      let(:second_card_suit) { Suit::Spade }
      let(:first_card_rank) { 10 }
      let(:second_card_rank) { RankPicture::J }
      it "trueを返す" do
        expect(first_card.is_series?(second_card)).to eq true
      end
    end
    context "1つ違いじゃない場合" do
      let(:first_card_suit) { Suit::Diamond }
      let(:second_card_suit) { Suit::Spade }
      let(:first_card_rank) { 10 }
      let(:second_card_rank) { RankPicture::Q }
      it "falseを返す" do
        expect(first_card.is_series?(second_card)).to eq false
      end
    end
  end
end
