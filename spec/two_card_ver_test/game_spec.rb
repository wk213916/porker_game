require 'rspec'
require_relative '../src/porker_hand'
require_relative '../src/card'
require_relative '../src/hand'
require_relative '../src/game'

describe "Game" do
  describe "２つの手札の役が異なる場合の比較" do
    context "player_handの方が強い場合" do
      game = Game.new(Hand.new(Card.new(Suit::Spade, RankPicture::Q), Card.new(Suit::Clover, RankPicture::K)), Hand.new(Card.new(Suit::Spade, 8), Card.new(Suit::Clover, 9)))
      it "player_handの@winningにGameResult::Winが返り、cpu_handの@winningにGameResult::Loseが返る" do
        game.judge_result
        expect(game.hands[:player_hand].winning).to eq GameResult::Win
        expect(game.hands[:cpu_hand].winning).to eq GameResult::Lose
      end
    end
    context "cpu_handの方が強い場合" do
      game = Game.new(Hand.new(Card.new(Suit::Spade, 8), Card.new(Suit::Clover, 9)), Hand.new(Card.new(Suit::Spade, RankPicture::Q), Card.new(Suit::Clover, RankPicture::K)))
      it "player_handの@winningにGameResult::Winが返り、cpu_handの@winningにGameResult::Loseが返る" do
        game.judge_result
        expect(game.hands[:player_hand].winning).to eq GameResult::Lose
        expect(game.hands[:cpu_hand].winning).to eq GameResult::Win
      end
    end
  end
  describe "２つの手札の役が同じ場合の比較" do
    describe "役がハイカード、フラッシュ、ペアの場合" do
      context "ハイカード同士の場合、Rankが大きい札を持つ方が勝つ" do
        game = Game.new(Hand.new(Card.new(Suit::Spade, RankPicture::A), Card.new(Suit::Clover, 4)), Hand.new(Card.new(Suit::Spade, RankPicture::K), Card.new(Suit::Clover, 10)))
        it "Rankが大きい札を持つ、player_handが勝つ" do
          game.judge_result
          expect(game.hands[:player_hand].winning).to eq GameResult::Win
          expect(game.hands[:cpu_hand].winning).to eq GameResult::Lose
        end
      end
      context "ハイカード同士で、強い方の札のRankも同じだった場合、弱い方の札のRankが大きい方が勝つ" do
        game = Game.new(Hand.new(Card.new(Suit::Spade, RankPicture::K), Card.new(Suit::Clover, 7)), Hand.new(Card.new(Suit::Heart, RankPicture::K), Card.new(Suit::Diamond, 10)))
        it "2枚目の札が強い、cpu_handの方が勝つ" do
          game.judge_result
          expect(game.hands[:player_hand].winning).to eq GameResult::Lose
          expect(game.hands[:cpu_hand].winning).to eq GameResult::Win
        end
      end
      context "フラッシュ同士の場合、強い札のRankが大きい方が勝つ" do
        game = Game.new(Hand.new(Card.new(Suit::Spade, RankPicture::A), Card.new(Suit::Spade, 4)), Hand.new(Card.new(Suit::Clover, RankPicture::K), Card.new(Suit::Clover, 10)))
        it "Rankが大きい札を持つ、player_handが勝つ" do
          game.judge_result
          expect(game.hands[:player_hand].winning).to eq GameResult::Win
          expect(game.hands[:cpu_hand].winning).to eq GameResult::Lose
        end
      end
      context "フラッシュ同士で、強い方の札のRankも同じだった場合、弱い方の札のRankが大きい方が勝つ" do
        game = Game.new(Hand.new(Card.new(Suit::Spade, RankPicture::K), Card.new(Suit::Spade, 3)), Hand.new(Card.new(Suit::Spade, RankPicture::K), Card.new(Suit::Spade, 7)))
        it "2枚目の札が強い、cpu_handの方が勝つ" do
          game.judge_result
          expect(game.hands[:player_hand].winning).to eq GameResult::Lose
          expect(game.hands[:cpu_hand].winning).to eq GameResult::Win
        end
      end
      context "ペア同士の場合、札のRankが大きい方が勝つ" do
        game = Game.new(Hand.new(Card.new(Suit::Heart, RankPicture::K), Card.new(Suit::Diamond, RankPicture::K)), Hand.new(Card.new(Suit::Spade, 10), Card.new(Suit::Clover, 10)))
        it "手札のRankが大きい、player_handが勝つ" do
          game.judge_result
          expect(game.hands[:player_hand].winning).to eq GameResult::Win
          expect(game.hands[:cpu_hand].winning).to eq GameResult::Lose
        end
      end
    end
    describe "役がストレート、ストレートフラッシュの場合" do
      context "ストレート、ストレートフラッシュの場合、Aと2の組み合わせが最弱" do
        game = Game.new(Hand.new(Card.new(Suit::Spade, RankPicture::A), Card.new(Suit::Clover, 2)), Hand.new(Card.new(Suit::Spade, 2), Card.new(Suit::Clover, 3)))
        it "2-3のストレートのcpuハンドに、A-2 のストレートのplayer_handが負ける" do
          game.judge_result
          expect(game.hands[:player_hand].winning).to eq GameResult::Lose
          expect(game.hands[:cpu_hand].winning).to eq GameResult::Win
        end
        game = Game.new(Hand.new(Card.new(Suit::Spade, RankPicture::A), Card.new(Suit::Spade, 2)), Hand.new(Card.new(Suit::Clover, 2), Card.new(Suit::Clover, 3)))
        it "2-3のストレートフラッシュのcpuハンドに、A-2 のストレートフラッシュのplayer_handが負ける" do
          game.judge_result
          expect(game.hands[:player_hand].winning).to eq GameResult::Lose
          expect(game.hands[:cpu_hand].winning).to eq GameResult::Win
        end
      end
      context "ストレート同士の場合、大きい手札の組み合わせを持つ方がかつ" do
        game = Game.new(Hand.new(Card.new(Suit::Heart, RankPicture::J), Card.new(Suit::Diamond, RankPicture::Q)), Hand.new(Card.new(Suit::Spade, 6), Card.new(Suit::Clover, 7)))
        it "rankが大きい組み合わせを持つplayer_handが勝つ" do
          game.judge_result
          expect(game.hands[:player_hand].winning).to eq GameResult::Win
          expect(game.hands[:cpu_hand].winning).to eq GameResult::Lose
        end
      end
      context "ストレートフラッシュ同士の場合、大きい手札の組み合わせを持つ方がかつ" do
        game = Game.new(Hand.new(Card.new(Suit::Heart, RankPicture::J), Card.new(Suit::Heart, RankPicture::Q)), Hand.new(Card.new(Suit::Spade, 6), Card.new(Suit::Spade, 7)))
        it "rankが大きい組み合わせを持つplayer_handが勝つ" do
          game.judge_result
          expect(game.hands[:player_hand].winning).to eq GameResult::Win
          expect(game.hands[:cpu_hand].winning).to eq GameResult::Lose
        end
      end
    end
  end
end
