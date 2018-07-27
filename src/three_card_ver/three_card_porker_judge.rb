require_relative "../base_porker_class/porker_hand.rb"
require_relative "../base_porker_class/judge.rb"

class ThreeCardPorkerJudge < Judge

  def judge_by_card_score
    # handは自分の役を知っている必要はあるが、judgeにこんな冗長に書きたくない。「Pair?」
    if [ThreeCardPorkerHandRole::Pair[:score]].include?(player_hand.role[:score])
      pair_roles_by_card_scores
    elsif [ThreeCardPorkerHandRole::StraightFlash[:score], ThreeCardPorkerHandRole::Straight[:score]].include?(player_hand.role[:score])
      straight_roles_by_card_scores
    else
      roles_by_card_scores
    end
  end
# ペアの役の際のカード同士を比較している
  def pair_roles_by_card_scores
    # 残った一枚の取り出し方、
    player_left_card_scores = (player_hand.card_scores - player_hand.paird_card_scores)
    cpu_left_card_scores = (cpu_hand.card_scores - cpu_hand.paird_card_scores)
    return compare_hand_cards(player_left_card_scores, cpu_hand.paird_card_scores) if player_hand.paird_card_scores == cpu_hand.paird_card_scores
    compare_hand_cards(player_hand.paird_card_scores, cpu_hand.paird_card_scores)
  end

  def straight_roles_by_card_scores
    return result_in_draw! if cpu_hand.weakest_straight? && player_hand.weakest_straight?
    return result_in_player_win! if cpu_hand.weakest_straight?
    return result_in_player_lose! if player_hand.weakest_straight?
    roles_by_card_scores
  end

  def roles_by_card_scores
    compare_hand_cards(player_hand.card_scores, cpu_hand.card_scores)
  end

private
  def compare_hand_cards(player_card_scores, cpu_card_scores)
    player_card_scores_to_compare = player_card_scores.to_enum
    cpu_card_scores_to_compare = cpu_card_scores.to_enum

    player_card_scores.length.times do
      player_card_score = player_card_scores_to_compare.next
      cpu_card_score = cpu_card_scores_to_compare.next
      return result_in_player_win! if  player_card_score > cpu_card_score
      return result_in_player_lose! if player_card_score < cpu_card_score
    end
    result_in_draw!
  end
end
# 行ごとに何をしているかが読み取りづらい
# judgeの中のメソッド名でjudgeという単語は使わなくていい、邪魔


# roleが同じ時に比較していくが、、pairの時の挙動が不自然。途中の結果をplayerに持たせたくない
# テストでは細かいところまでチェックする
# いきなり勝敗を返す、階層が一段階上のことをやっている。よく使う値なら、hashなどわかりやすい形で返した方が良い

# compare_hand_cardsをもうすこし汎用的に使えるようにする
# handで中間の値を持てるようにする、etc
# 責任分担をしっかり。。
