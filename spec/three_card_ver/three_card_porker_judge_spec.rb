require 'rspec'
require_relative '../../src/base_porker_class/porker_hand'
require_relative '../../src/base_porker_class/player'
require_relative '../../src/three_card_ver/three_card_porker_hand'
require_relative '../../src/three_card_ver/three_card_porker_judge'

describe "ThreeCardPorkerJudge" do
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
  describe "引き分けの場合、手札の強さで勝敗を判定" do
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
      context "プレイヤーのペアのカードとCpuのペアーのカードが同じ場合" do
        context "プレイヤーのペアになっていないカードの方がCpuより大きい場合" do
          let(:player_first_card) { Card.new(Suit::Spade, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
          let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
          let(:player_third_card) { Card.new(Suit::Clover, CardRank::Rank8[:rank], CardRank::Rank8[:score]) }
          let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
          let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
          let(:cpu_third_card) { Card.new(Suit::Diamond, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
          it "プレイヤーの勝利になる" do
            expect(judge.player_winning[:result]).to eq GameResult::Win
          end
          it "Cpuの負けになる" do
            expect(judge.cpu_winning[:result]).to eq GameResult::Lose
          end
        end
        context "Cpuのペアになっていないカードの方がプレイヤーより大きい場合" do
          let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankA[:rank], CardRank::RankA[:score]) }
          let(:player_second_card) { Card.new(Suit::Clover, CardRank::RankA[:rank], CardRank::RankA[:score]) }
          let(:player_third_card) { Card.new(Suit::Clover, CardRank::Rank4[:rank], CardRank::Rank4[:score]) }
          let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::Rank9[:rank], CardRank::Rank9[:score]) }
          let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::RankA[:rank], CardRank::RankA[:score]) }
          let(:cpu_third_card) { Card.new(Suit::Diamond, CardRank::RankA[:rank], CardRank::RankA[:score]) }
          it "プレイヤーの負けになる" do
            expect(judge.player_winning[:result]).to eq GameResult::Lose
          end
          it "Cpuの勝利になる" do
            expect(judge.cpu_winning[:result]).to eq GameResult::Win
          end
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
      context "Cpuのカードの方がプレイヤーのカードよりも強い場合" do
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
      context "Cpuの1番強いカードとプレイヤーの1番強いカードが同じ場合" do
        context "プレイヤーの2番目に強いカードがCpuよりも強い場合" do
          let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score]) }
          let(:player_second_card) { Card.new(Suit::Spade, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
          let(:player_third_card) { Card.new(Suit::Spade, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
          let(:cpu_first_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
          let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
          let(:cpu_third_card) { Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]) }
          it "プレイヤーの勝利になる" do
            expect(judge.player_winning[:result]).to eq GameResult::Win
          end
          it "Cpuの負けになる" do
            expect(judge.cpu_winning[:result]).to eq GameResult::Lose
          end
        end
        context "Cpuの2番目に強いカードがプレイヤーよりも強い場合" do
          let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score]) }
          let(:player_second_card) { Card.new(Suit::Spade, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
          let(:player_third_card) { Card.new(Suit::Spade, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
          let(:cpu_first_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
          let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
          let(:cpu_third_card) { Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]) }
          it "プレイヤーの負けになる" do
            expect(judge.player_winning[:result]).to eq GameResult::Lose
          end
          it "Cpuの勝利になる" do
            expect(judge.cpu_winning[:result]).to eq GameResult::Win
          end
        end
        context "Cpuの2番目に強いカードとプレイヤーの2番目に強いカードも同じ場合" do
          context "プレイヤーの3番目に強いカードがCpuよりも強い場合" do
            let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score]) }
            let(:player_second_card) { Card.new(Suit::Spade, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
            let(:player_third_card) { Card.new(Suit::Spade, CardRank::Rank6[:rank], CardRank::Rank6[:score]) }
            let(:cpu_first_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
            let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
            let(:cpu_third_card) { Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]) }
            it "プレイヤーの勝利になる" do
              expect(judge.player_winning[:result]).to eq GameResult::Win
            end
            it "Cpuの負けになる" do
              expect(judge.cpu_winning[:result]).to eq GameResult::Lose
            end
          end
          context "cpuの3番目に強いカードがプレイヤーよりも強い場合" do
            let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score]) }
            let(:player_second_card) { Card.new(Suit::Spade, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
            let(:player_third_card) { Card.new(Suit::Spade, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
            let(:cpu_first_card) { Card.new(Suit::Clover, CardRank::Rank6[:rank], CardRank::Rank6[:score]) }
            let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
            let(:cpu_third_card) { Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]) }
            it "プレイヤーの負けになる" do
              expect(judge.player_winning[:result]).to eq GameResult::Lose
            end
            it "Cpuの勝ちになる" do
              expect(judge.cpu_winning[:result]).to eq GameResult::Win
            end
          end
          context "3番目に強いカードも両方同じ場合" do
            let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankK[:rank], CardRank::RankK[:score]) }
            let(:player_second_card) { Card.new(Suit::Spade, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
            let(:player_third_card) { Card.new(Suit::Spade, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
            let(:cpu_first_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
            let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
            let(:cpu_third_card) { Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]) }
            it "引き分けになる" do
              expect(judge.player_winning[:result]).to eq GameResult::Draw
              expect(judge.cpu_winning[:result]).to eq GameResult::Draw
            end
          end
        end
      end
    end
    describe "ストレート、ストレートフラッシュの場合の判定" do
      context "プレイヤーの一番強いカードのスコアがCpuの一番強いカードのスコアよりも大きい場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankJ[:rank], CardRank::RankJ[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank10[:rank], CardRank::Rank10[:score]) }
        let(:player_third_card) { Card.new(Suit::Diamond, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank6[:rank], CardRank::Rank6[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Heart, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
        it "プレイヤーの勝利になる" do
          expect(judge.player_winning[:result]).to eq GameResult::Win
        end
        it "Cpuの負けになる" do
          expect(judge.cpu_winning[:result]).to eq GameResult::Lose
        end
      end
      context "Cpuのカードがプレイヤーよりも強い場合" do
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
      context "Cpuの組み合わせが[A-2-3]の場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank6[:rank], CardRank::Rank6[:score]) }
        let(:player_third_card) { Card.new(Suit::Heart, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::RankA[:rank], CardRank::RankA[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank2[:rank], CardRank::Rank2[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Diamond, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
        it "Playerが[A-2-3]以外なら、Playerの勝利になる" do
          expect(judge.player_winning[:result]).to eq GameResult::Win
        end
        it "Playerが[A-2-3]以外なら、Cpuの負けになる" do
          expect(judge.cpu_winning[:result]).to eq GameResult::Lose
        end
      end
      context "Playerの組み合わせが[A-2-3]の場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankA[:rank], CardRank::RankA[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank2[:rank], CardRank::Rank2[:score]) }
        let(:player_third_card) { Card.new(Suit::Diamond, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank6[:rank], CardRank::Rank6[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Heart, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
        it "Cpuが[A-2-3]以外なら、Playerの負けになる" do
          expect(judge.player_winning[:result]).to eq GameResult::Lose
        end
        it "Cpuが[A-2-3]以外なら、Cpuの勝利になる" do
          expect(judge.cpu_winning[:result]).to eq GameResult::Win
        end
      end
      context "PlayerもCpuも組み合わせが[A-2-3]の場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankA[:rank], CardRank::RankA[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank2[:rank], CardRank::Rank2[:score]) }
        let(:player_third_card) { Card.new(Suit::Diamond, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Clover, CardRank::RankA[:rank], CardRank::RankA[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank3[:rank], CardRank::Rank3[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Heart, CardRank::Rank2[:rank], CardRank::Rank2[:score]) }
        it "引き分けになる" do
          expect(judge.player_winning[:result]).to eq GameResult::Draw
          expect(judge.cpu_winning[:result]).to eq GameResult::Draw
        end
      end
      context "Cpuの組み合わせが[Q-K-A]の場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::Rank6[:rank], CardRank::Rank6[:score]) }
        let(:player_third_card) { Card.new(Suit::Heart, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Heart, CardRank::RankA[:rank], CardRank::RankA[:score]) }
        it "Playerが[Q-K-A]以外なら、Playerの負けになる" do
          expect(judge.player_winning[:result]).to eq GameResult::Lose
        end
        it "Playerが[Q-K-A]以外なら、Cpuの負けになる" do
          expect(judge.cpu_winning[:result]).to eq GameResult::Win
        end
      end
      context "Playerの組み合わせが[Q-K-A]の場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankA[:rank], CardRank::RankA[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]) }
        let(:player_third_card) { Card.new(Suit::Diamond, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Spade, CardRank::Rank5[:rank], CardRank::Rank5[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::Rank6[:rank], CardRank::Rank6[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Heart, CardRank::Rank7[:rank], CardRank::Rank7[:score]) }
        it "Cpuが[O-K-A]以外なら、Playerの勝利になる" do
          expect(judge.player_winning[:result]).to eq GameResult::Win
        end
        it "Cpuが[Q-K-A]以外なら、Cpuの勝利になる" do
          expect(judge.cpu_winning[:result]).to eq GameResult::Lose
        end
      end
      context "PlayerもCpuも組み合わせが[Q-K-A]の場合" do
        let(:player_first_card) { Card.new(Suit::Spade, CardRank::RankA[:rank], CardRank::RankA[:score]) }
        let(:player_second_card) { Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]) }
        let(:player_third_card) { Card.new(Suit::Diamond, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
        let(:cpu_first_card) { Card.new(Suit::Clover, CardRank::RankK[:rank], CardRank::RankK[:score]) }
        let(:cpu_second_card) { Card.new(Suit::Clover, CardRank::RankQ[:rank], CardRank::RankQ[:score]) }
        let(:cpu_third_card) { Card.new(Suit::Heart, CardRank::RankA[:rank], CardRank::RankA[:score]) }
        it "引き分けになる" do
          expect(judge.player_winning[:result]).to eq GameResult::Draw
          expect(judge.cpu_winning[:result]).to eq GameResult::Draw
        end
      end
    end
  end
end
