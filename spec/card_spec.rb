require 'rspec'
require_relative '../src/card'

describe "Card" do
  describe "get_notationメソッドの挙動" do
    context "引数スペードの3のチェック" do
      card = Card.new("♠️", 3)
      it "get_notationのテスト" do
        expect(card.get_notation).to eq "3♠️"
      end
    end
    context "引数ハートのJのチェック" do
      card = Card.new("♡", 10)
      it "返り値がJ♡になる" do
        expect(card.get_notation).to eq "10♡"
      end
    end
  end

  describe "has_same_suitメソッドの挙動" do
    context "suitが同じである場合" do
      first_card = Card.new("♡",3)
      second_card = Card.new("♡", 8)
      it "trueを返す" do
        expect(first_card.has_same_suit(second_card)).to eq true
      end
    end
    context "suitが異なる場合" do
      first_card = Card.new("♡",3)
      second_card = Card.new("♤", 8)
      it "falseを返す" do
        expect(first_card.has_same_suit(second_card)).to eq false
      end
    end
  end

  describe "has_same_rankメソッドの挙動" do
    context "rankが同じ場合"do
      first_card = Card.new("♤",3)
      second_card = Card.new("♧", 3)
      it "trueを返す" do
        expect(first_card.has_same_rank(second_card)).to eq true
      end
    end
    context "rankが異なる場合" do
      first_card = Card.new("♤", 3)
      second_card = Card.new("♧", 5)
      it "falseを返す" do
        expect(first_card.has_same_rank(second_card)).to eq false
      end
    end
  end
end
