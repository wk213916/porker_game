# Todo: letを使って書き直す、メソッド名を追記する
# Todo: letの書き方。細かく分けて、途中で変えられる様にする。

require 'rspec'
require_relative '../../src/base_porker_class/porker_hand'
require_relative '../../src/base_porker_class/card'
require_relative '../../src/base_porker_class/player'
require_relative '../../src/three_card_ver/three_card_porker_hand'

describe "Judge" do
  let(:player) do
    Player.new(
      ThreeCardPorkerHand.new(
        player_first_card, player_second_card, player_third_card
      )
    )
  end
  let(:player_first_card) {nil}
  let(:player_second_card) {nil}
  let(:player_third_card) {nil}

  let(:cpu) do
    Player.new(
      ThreeCardPorkerHand.new(
        cpu_first_card, cpu_second_card, cpu_third_card
      )
    )
  end
  let(:cpu_first_card) {nil}
  let(:cpu_second_card) {nil}
  let(:cpu_third_card) {nil}

  let(:judge) do
    Judge.new(
      player.hand, cpu.hand
    )
  end

  describe "勝敗の判定" do
    before do
      judge.role_score_judge
    end
    context "CPUの役の点数よりプレイヤーの役の点数の方が大きい場合" do
      let(:player_first_card) { Card.new(Suit::Spade, 10) }
      let(:player_second_card) { Card.new(Suit::Clover, 10) }
      let(:player_third_card) { Card.new(Suit::Clover, 10) }
      let(:cpu_first_card) { Card.new(Suit::Spade, 5) }
      let(:cpu_second_card) { Card.new(Suit::Clover, 4) }
      let(:cpu_third_card) { Card.new(Suit::Diamond, 2) }
      it "プレイヤーの勝利になる" do
        expect(judge.player_winning[:result]).to eq GameResult::Win
      end
      it "CPUの負けになる" do
        expect(judge.cpu_winning[:result]).to eq GameResult::Lose
      end
    end
    context "プレイヤーの役の点数よりCPUの役の点数の方が大きい場合" do
      let(:player_first_card) { Card.new(Suit::Spade, 2) }
      let(:player_second_card) { Card.new(Suit::Clover, 3) }
      let(:player_third_card) { Card.new(Suit::Clover, 4) }
      let(:cpu_first_card) { Card.new(Suit::Spade, 5) }
      let(:cpu_second_card) { Card.new(Suit::Clover, 5) }
      let(:cpu_third_card) { Card.new(Suit::Diamond, 5) }
      it "CPUの勝利になる" do
        expect(judge.cpu_winning[:result]).to eq GameResult::Win
      end
      it "プレイヤーの負けになる" do
        expect(judge.player_winning[:result]).to eq GameResult::Lose
      end
    end
  end
end
