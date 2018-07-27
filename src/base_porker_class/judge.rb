class Judge
  attr_reader :player_hand, :cpu_hand
  attr_accessor :player_winning, :cpu_winning
  def initialize(player_hand, cpu_hand)
    @player_hand = player_hand
    @cpu_hand = cpu_hand
  end

  def role_score_judge
    if cpu_hand.role[:score] < player_hand.role[:score]
      result_in_player_win!
    elsif cpu_hand.role[:score] > player_hand.role[:score]
      result_in_player_lose!
    else
      judge_by_card_score
    end
  end

  def result_in_player_win!
    @player_winning = { result: GameResult::Win, role: player_hand.role }
    @cpu_winning = { result: GameResult::Lose, role: cpu_hand.role }
  end

  def result_in_player_lose!
    @player_winning = { result: GameResult::Lose, role: player_hand.role }
    @cpu_winning = { result: GameResult::Win, role: cpu_hand.role }
  end

  def result_in_draw!
    @player_winning = { result: GameResult::Draw, role: player_hand.role }
    @cpu_winning = { result: GameResult::Draw, role: cpu_hand.role }
  end

  def judge_by_card_score
    raise NotImplementedEroor.new("このメソッドはオーバライドしないとエラーになります")
  end
end
