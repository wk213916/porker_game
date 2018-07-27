進捗
①テストコードをパスした

変更箇所
①カードのsuitを定数で扱う
②card_score_judgeの箇所の条件分岐をメソッド内部で行う

7/25 質問箇所
ver 1
上手くいった
def result_judge_by_score
  player_cards_score = player_hand.cards_orderd_by_score.map{|card| card.score}.to_enum
  cpu_cards_score = cpu_hand.cards_orderd_by_score.map{|card| card.score}.to_enum
    player_hand.cards.length.times do
      a = player_cards_score.next
      b = cpu_cards_score.next
      return result_in_player_win if  a > b
      return result_in_player_lose if a < b
    end
  return result_in_draw
end

ver2
Failure/Error: expect(judge.player_winning[:result]).to eq GameResult::Draw

NoMethodError:
  undefined method [] for nil:NilClass

def result_judge_by_score
  player_cards_score = player_hand.cards_orderd_by_score.map{|card| card.score}.to_enum
  cpu_cards_score = cpu_hand.cards_orderd_by_score.map{|card| card.score}.to_enum

    player_hand.cards.length.times do
      begin
        a = player_cards_score.next
        b = cpu_cards_score.next
        return result_in_player_win if  a > b
        return result_in_player_lose if a < b
      rescue StopIteration
        return result_in_draw
      end
    end
end

ver3
望んだ結果にならない
1) ThreeCardPorkerJudge 引き分けの場合、手札の強さで勝敗を判定 スリーカード、ハイカード、フラッシュの場合の判定 Cpuの1番強いカードとプレイヤーの1番強いカードが同じ場合 プレイヤーの2番目に強いカードがCpuよりも強い場合 プレイヤーの勝利になる
   Failure/Error: expect(judge.player_winning[:result]).to eq GameResult::Win

     expected: 1
          got: 0

     (compared using ==)
   # ./spec/three_card_ver/three_card_porker_judge_spec.rb:170:in `block (6 levels) in <top (required)>'

2) ThreeCardPorkerJudge 引き分けの場合、手札の強さで勝敗を判定 スリーカード、ハイカード、フラッシュの場合の判定 Cpuの1番強いカードとプレイヤーの1番強いカードが同じ場合 プレイヤーの2番目に強いカードがCpuよりも強い場合 Cpuの負けになる
   Failure/Error: expect(judge.cpu_winning[:result]).to eq GameResult::Lose

     expected: -1
          got: 0

def result_judge_by_score
  player_cards_score = player_hand.cards_orderd_by_score.map{|card| card.score}.to_enum
  cpu_cards_score = cpu_hand.cards_orderd_by_score.map{|card| card.score}.to_enum

  begin
    loop do
      return result_in_player_win if player_cards_score.next > cpu_cards_score.next
      return result_in_player_lose if player_cards_score.next < cpu_cards_score.next
    end
  rescue StopIteration
    return result_in_draw
  end
end

end
