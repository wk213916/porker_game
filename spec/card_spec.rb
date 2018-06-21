require 'rspec'
require_relative '../src/porker_hand'
require_relative '../src/card'

describe "Card" do
  describe "notationメソッドの挙動" do
    context "引数スペードの3のチェック" do
      card = Card.new("♠️", 3)
      it "notationのテスト" do
        expect(card.notation).to eq "3♠️"
      end
    end
    context "引数ハートのJのチェック" do
      card = Card.new("♡", 10)
      it "返り値がJ♡になる" do
        expect(card.notation).to eq "10♡"
      end
    end
  end

  describe "has_same_suitメソッドの挙動" do
    context "suitが同じである場合" do
      first_card = Card.new("♡",3)
      second_card = Card.new("♡", 8)
      it "trueを返す" do
        expect(first_card.has_same_suit?(second_card)).to eq true
      end
    end
    context "suitが異なる場合" do
      first_card = Card.new("♡",3)
      second_card = Card.new("♤", 8)
      it "falseを返す" do
        expect(first_card.has_same_suit?(second_card)).to eq false
      end
    end
  end

  describe "has_same_rankメソッドの挙動" do
    context "rankが同じ場合"do
      first_card = Card.new("♤",3)
      second_card = Card.new("♧", 3)
      it "trueを返す" do
        expect(first_card.has_same_rank?(second_card)).to eq true
      end
    end
    context "rankが異なる場合" do
      first_card = Card.new("♤", 3)
      second_card = Card.new("♧", 5)
      it "falseを返す" do
        expect(first_card.has_same_rank?(second_card)).to eq false
      end
    end
  end

  describe "役の判定" do
    context "rank が同じ場合" do
      ♤four = Card.new("♤", 4)
      ♧four = Card.new("♧", 4)
      it "ペアを返す" do
        expect(♤four.check_hand(♧four)).to eq Hand::Pair
      end
    end
    context "suit が同じ場合" do
      ♤four = Card.new("♤", 4)
      ♤five = Card.new("♤", 6)
      it "フラッシュを返す" do
        expect(♤four.check_hand(♤five)).to eq Hand::Flash
      end
    end
    context "2つとも異なる場合" do
      ♤four = Card.new("♤", 4)
      ♧five = Card.new("♧", 6)
      it "ハイカードを返す" do
        expect(♤four.check_hand(♧five)).to eq Hand::HighCard
      end
    end
  end

  describe "has_combinationメソッドの挙動" do
    context "連番の場合" do
      ♤four = Card.new("♤", 4)
      ♧five = Card.new("♧", 5)
      it "trueを返す" do
        expect(♤four.is_series?(♧five)).to eq true
      end
    end
    context "連番ではない場合" do
      ♤four = Card.new("♤", 4)
      ♧seven = Card.new("♧", 7)
      it "falseを返す" do
        expect(♤four.is_series?(♧seven)).to eq false
      end
    end
    context "AとKの場合" do
      ♤A = Card.new("♤", RankPicture::A)
      ♧K = Card.new("♧", RankPicture::K)
      it "trueを返す" do
        expect(♤A.is_series?(♧K)).to eq true
      end
    end
  end

  describe "役の判定の追加" do
    context "rankが連番でsuitも同じ場合" do
      ♤four = Card.new("♤", 4)
      ♤five = Card.new("♤", 5)
      it "ストレートフラッシュを返す" do
        expect(♤four.check_hand(♤five)).to eq Hand::StraightFlash
      end
    end
    context "rank が連番の場合" do
      ♤four = Card.new("♤", 4)
      ♧five = Card.new("♧", 5)
      it "ストレートを返す" do
        expect(♤four.check_hand(♧five)).to eq Hand::Straight
      end
    end
    context "ストレートフラッシュと他の組み合わせが両立している場合" do
      ♤four = Card.new("♤", 4)
      ♤five = Card.new("♤", 5)
      it "ストレートフラッシュを返す" do
        expect(♤four.check_hand(♤five)).to eq Hand::StraightFlash
      end
    end
  end

end
