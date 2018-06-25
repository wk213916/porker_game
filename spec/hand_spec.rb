require 'rspec'
require_relative '../src/porker_hand'
require_relative '../src/card'
require_relative '../src/hand'

describe "Hand" do
  describe "役同士の強さの比較" do
    it "ストレートフラッシュはペアより強い" do
      expect(HandCombination::StraightFlash[:hand_score] > HandCombination::Pair[:hand_score]).to eq true
    end
    it "ペアはストレートより強い" do
      expect(HandCombination::Pair[:hand_score] > HandCombination::Straight[:hand_score]).to eq true
    end
    it "ストレートはフラッシュより強い" do
      expect(HandCombination::Straight[:hand_score] > HandCombination::Flash[:hand_score]).to eq true
    end
    it "フラッシュはハイカードより強い" do
      expect(HandCombination::Flash[:hand_score] > HandCombination::HighCard[:hand_score]).to eq true
    end
  end
  describe "2つの手札の役の強さを比較" do
    context "first_handの方が強い場合" do
      first_hand = Hand.new(Card.new("♤", RankPicture::A), Card.new("♧", RankPicture::A))
      first_hand.porker_role = first_hand.cards[0].check_hand_card(first_hand.cards[1])
      second_hand = Hand.new(Card.new("♤", 7), Card.new("♧", 4))
      second_hand.porker_role = second_hand.cards[0].check_hand_card(second_hand.cards[1])
      it "first_handの@winningにGameResult::Winが返り、second_handの@winningにGameResult::Loseが返る" do
        result = first_hand.judge_result(second_hand)
        expect(first_hand.winning).to eq GameResult::Win
        expect(second_hand.winning).to eq GameResult::Lose
      end
    end
    context "second_handの方が強い場合" do
      first_hand = Hand.new(Card.new("♤", 4), Card.new("♧", 5))
      first_hand.porker_role = first_hand.cards[0].check_hand_card(first_hand.cards[1])
      second_hand = Hand.new(Card.new("♤", RankPicture::A), Card.new("♧", RankPicture::A))
      second_hand.porker_role = second_hand.cards[0].check_hand_card(second_hand.cards[1])
      it "first_handの@winningにGameResult::Winが返り、second_handの@winningにGameResult::Wingが返る" do
        result = first_hand.judge_result(second_hand)
        expect(first_hand.winning).to eq GameResult::Lose
        expect(second_hand.winning).to eq GameResult::Win
      end
    end
    context "同じ役の場合" do
      first_hand = Hand.new(Card.new("♤", 5), Card.new("♧", 5))
      first_hand.porker_role = first_hand.cards[0].check_hand_card(first_hand.cards[1])
      second_hand = Hand.new(Card.new("♡", 4), Card.new("♢", 4))
      second_hand.porker_role = second_hand.cards[0].check_hand_card(second_hand.cards[1])
      it "両方の@winningにGameResult::Drawが返る" do
        result = first_hand.judge_result(second_hand)
        expect(first_hand.winning).to eq GameResult::Draw
        expect(second_hand.winning).to eq GameResult::Draw
      end
    end
  end
end
