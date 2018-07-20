require 'rspec'
require_relative '../../src/base_porker_class/porker_hand'
require_relative '../../src/base_porker_class/card'
require_relative '../../src/three_card_ver/three_card_porker_game'
require_relative '../../src/base_porker_class/judge'
require_relative '../../src/three_card_ver/three_card_porker_hand'

describe "Game" do
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

  let(:game) do
    Game.new(
      player, cpu
    )
  end
  describe "生成されたときに必要な値を持つ" do
    let(:player_first_card) { Card.new(Suit::Spade, 10) }
    let(:player_second_card) { Card.new(Suit::Clover, 10) }
    let(:player_third_card) { Card.new(Suit::Clover, 10) }
    let(:cpu_first_card) { Card.new(Suit::Spade, 5) }
    let(:cpu_second_card) { Card.new(Suit::Clover, 4) }
    let(:cpu_third_card) { Card.new(Suit::Diamond, 2) }
    it "playerが生成される" do
      expect(game.player).to be game.player
      expect(game.player).to be_an_instance_of(Player)
    end
    it "cpuが生成される" do
      expect(game.cpu).to be game.cpu
      expect(game.player).to be_an_instance_of(Player)
    end
    it "judgeが生成される" do
      expect(game.judge).to be game.judge
      expect(game.judge).to be_an_instance_of(Judge)
    end
  end
  describe "judge_resultメソッドの挙動" do
    before do
      game.result
    end
    let(:player_first_card) { Card.new(Suit::Spade, 10) }
    let(:player_second_card) { Card.new(Suit::Clover, 10) }
    let(:player_third_card) { Card.new(Suit::Clover, 10) }
    let(:cpu_first_card) { Card.new(Suit::Spade, 5) }
    let(:cpu_second_card) { Card.new(Suit::Clover, 4) }
    let(:cpu_third_card) { Card.new(Suit::Diamond, 2) }
    it "judgeが判定したplayerの役を返す" do
      expect(game.player.hand.role).to eq ThreeCardPorkerHandRole::ThreeCard
    end
    it "judgeが判定したcpuの役を返す" do
      expect(game.cpu.hand.role).to eq ThreeCardPorkerHandRole::HighCard
    end
    it "cpuとplayerの役を比較して勝敗が決まる" do
      expect(game.judge.player_winning[:result]).to eq GameResult::Win
      expect(game.judge.cpu_winning[:result]).to eq GameResult::Lose
    end
  end
end
