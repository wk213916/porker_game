# Todo: letを使って書き直す、メソッド名を追記する
# Todo: letの書き方。細かく分けて、途中で変えられる様にする。

require 'rspec'
require_relative '../../src/base_porker_class/porker_hand'
require_relative '../../src/base_porker_class/card'
require_relative '../../src/base_porker_class/player'
require_relative '../../src/base_porker_class/judge'
require_relative '../../src/three_card_ver/three_card_porker_hand'
require_relative '../../src/three_card_ver/three_card_porker_judge'

describe "Judge" do
  let(:player) do
    Player.new(
      ThreeCardPorkerHand.new(
        [player_first_card, player_second_card, player_third_card]
      )
    )
  end
  let(:player_first_card) {nil}
  let(:player_second_card) {nil}
  let(:player_third_card) {nil}

  let(:cpu) do
    Player.new(
      ThreeCardPorkerHand.new(
        [cpu_first_card, cpu_second_card, cpu_third_card]
      )
    )
  end
  let(:cpu_first_card) {nil}
  let(:cpu_second_card) {nil}
  let(:cpu_third_card) {nil}

  let(:judge) do
    ThreeCardPorkerJudge.new(
      player.hand, cpu.hand
    )
  end

  describe "勝敗の判定" do
    before do
      judge.role_score_judge
    end
    context "CPUの役の点数よりプレイヤーの役の点数の方が大きい場合" do
      let(:player_first_card) { Card.new(Suit::Spade, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
      let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
      let(:player_third_card) { Card.new(Suit::Clover, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
      let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
      let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank4[:rank], CardRank::Rank4[:score]) }
      let(:cpu_third_card) { Card.new(Suit::Diamond, CardRank::Rank2[:rank], CardRank::Rank2[:score]) }
      it "プレイヤーの勝利になる" do
        expect(judge.player_winning[:result]).to eq GameResult::Win
      end
      it "CPUの負けになる" do
        expect(judge.cpu_winning[:result]).to eq GameResult::Lose
      end
    end
    context "プレイヤーの役の点数よりCPUの役の点数の方が大きい場合" do
      let(:player_first_card) { Card.new(Suit::Spade, CardRank::Rank2[:rank], CardRank::Rank2[:score]) }
      let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
      let(:player_third_card) { Card.new(Suit::Clover, CardRank::Rank4[:rank], CardRank::Rank4[:score]) }
      let(:cpu_first_card) { Card.new(Suit::Spade,  CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
      let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
      let(:cpu_third_card) { Card.new(Suit::Diamond, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
      it "CPUの勝利になる" do
        expect(judge.cpu_winning[:result]).to eq GameResult::Win
      end
      it "プレイヤーの負けになる" do
        expect(judge.player_winning[:result]).to eq GameResult::Lose
      end
    end
  end
  describe "引き分けの場合の判定" do
    before do
      judge.role_score_judge
    end
    describe "ペアの場合の判定" do
      context "プレイヤーのペアのカードの方がCpuよりも強い場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
        let(:player_third_card) { Card.new(Suit::Clover, CardRank::Rank8[:rank], CardRank::Rank8[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Diamond, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
        it "プレイヤーの勝利になる" do
          expect(judge.player_winning[:result]).to eq GameResult::Win
        end
        it "Cpuの負けになる" do
          expect(judge.cpu_winning[:result]).to eq GameResult::Lose
        end
      end
      context "プレイヤーのペアのカードの方がCpuよりも強い場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
        let(:player_third_card) { Card.new(Suit::Clover, CardRank::Rank8[:rank], CardRank::Rank8[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank9[:rank], CardRank::Rank9[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Diamond, CardRank::Rank9[:rank], CardRank::Rank9[:score]) }
        it "プレイヤーの負けになる" do
          expect(judge.player_winning[:result]).to eq GameResult::Lose
        end
        it "Cpuの勝利になる" do
          expect(judge.cpu_winning[:result]).to eq GameResult::Win
        end
      end
    end
    describe "スリーカード、ハイカード、フラッシュの場合の判定" do
      context "プレイヤーのカードがCPUのカードよりも強い場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::Rank10[:rank], CardRank::Rank10[:score] ) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
        let(:player_third_card) { Card.new(Suit::Clover, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Diamond, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        it "プレイヤーの勝利になる" do
          expect(judge.player_winning[:result]).to eq GameResult::Win
        end
        it "CPUの負けになる" do
          expect(judge.cpu_winning[:result]).to eq GameResult::Lose
        end
      end
      context "Cpuのカードの方がPlayerのカードよりも強い場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:player_third_card) { Card.new(Suit::Clover, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Diamond, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
        it "プレイヤーの負けになる" do
          expect(judge.player_winning[:result]).to eq GameResult::Lose
        end
        it "Cpuの勝利になる" do
          expect(judge.cpu_winning[:result]).to eq GameResult::Win
        end
      end
      context "ストレート、ストレートフラッシュの場合の判定" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank6[:rank], CardRank::Rank6[:score]) }
        let(:player_third_card) { Card.new(Suit::Heart, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::RankJ[:rank], CardRank::RankJ[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Diamond, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
        it "プレイヤーの負けになる" do
          expect(judge.player_winning[:result]).to eq GameResult::Lose
        end
        it "Cpuの勝利になる" do
          expect(judge.cpu_winning[:result]).to eq GameResult::Win
        end
      end
    end
  end
end
