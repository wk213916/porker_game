# 上手くいく方
def judge_result
  if @hands[:player_hand].role[:score] && @hands[:cpu_hand].role[:score] == 0 || 1 || 3
    @hands[:player_hand].card_score_judge(@hands[:cpu_hand])
  elsif @hands[:player_hand].role[:score] && @hands[:cpu_hand].role[:score] == 2 || 4
    @hands[:cpu_hand].card_score_judge_straight(@hands[:cpu_hand])
  end
end
# 上手くいかない方
def judge_result
  @hands[:player_hand].card_score_judge(@hands[:cpu_hand]) if @hands[:player_hand].role[:score] && @hands[:cpu_hand].role[:score] == 0 || 1 || 3
  @hands[:player_hand].card_score_judge_straight(@hands[:cpu_hand]) if @hands[:player_hand].role[:score] && @hands[:cpu_hand].role[:score] == 2 || 4
end
