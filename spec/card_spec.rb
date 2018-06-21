require 'rspec'
require_relative '../src/card'

describe "Card" do
  describe "get_notationメソッドの挙動" do
    context "引数スペードの3のチェック" do
      card = Card.new("♠️", "3")
      it "get_notationのテスト" do
        expect(card.get_notation).to eq "3♠️"
      end
    end
    context "引数ハートのJのチェック" do
      card = Card.new("♡", "J")
      it "返り値がJ♡になる" do
        expect(card.get_notation).to eq "J♡"
      end
    end
  end

  describe "has_same_suitメソッドの挙動" do
    context "has_same_suitメソッドで比較するオブジェクト" do
      first_card = Card.new("♡","3")
      second_card = Card.new("♡", "8")
      it "引数のオブジェクトと suit が同じ場合、trueを返す" do
        expect(first_card.has_same_suit(second_card)).to eq true
      end
    end
  end

  describe "has_same_rankメソッドの挙動" do
    context "has_same_rankで比較するオブジェクト"do
      first_card = Card.new("♤","3")
      second_card = Card.new("♧", "3")
      it "引数のオブジェクトと rank が同じ場合、trueを返す" do
        expect(first_card.has_same_rank(second_card)).to eq true
      end
    end
  end
end
