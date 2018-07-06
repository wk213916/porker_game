require 'rspec'
require_relative '../../src/three_card_ver/porker_hand'
require_relative '../../src/three_card_ver/card'
require_relative '../../src/three_card_ver/hand'

describe "Hand" do
  describe "必要な値が入っているかのチェック" do
    describe "initialize_card_suitsメソッドの挙動" do
      hand = Hand.new(Card.new(Suit::Spade, RankPicture::Q), Card.new(Suit::Clover, RankPicture::K))
      it "handのsuitの絵柄のみの配列ができる" do
        hand.initialize_card_suits
        expect(hand.suits_picture).to eq [Suit::Spade[:picture], Suit::Clover[:picture]]
      end
      it "handの枚数に応じた、手札をチェックするのに必要な回数が定義されている" do
        expect(hand.check_times).to eq hand.cards.length - 1
      end
    end
    describe "3枚以上の時のストレート、ストレートフラッシュの判定" do
      context "ストレート、ストレートフラッシュのいずれかが成立している場合" do
        hand = Hand.new(Card.new(Suit::Spade, RankPicture::J), Card.new(Suit::Spade, RankPicture::Q), Card.new(Suit::Clover, RankPicture::K))
        expect(hand.is_series_card_role?). to eq true
      end
      context "ストレート、ストレートフラッシュのいずれも成立していない場合" do
        hand = Hand.new(Card.new(Suit::Spade, RankPicture::J), Card.new(Suit::Spade, 9), Card.new(Suit::Clover, RankPicture::K))
        expect(hand.is_series_card_role?). to eq false
      end
    end
    describe "ストレートとストレートフラッシュの区別" do
      
    end

  end
end
