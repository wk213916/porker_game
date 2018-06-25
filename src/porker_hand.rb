module RankPicture
  A = 1.freeze
  J = 11.freeze
  Q = 12.freeze
  K = 13.freeze
end

module HandCombination
  HighCard = {name: "ハイカード", hand_score: 0, }.freeze
  Flash = {name: "フラッシュ", hand_score: 1}.freeze
  Straight = {name: "ストレート", hand_score: 2}.freeze
  Pair = {name: "ペア", hand_score: 3}.freeze
  StraightFlash = {name: "ストレートフラッシュ", hand_score: 4}.freeze
end

module GameResult
  Win = 1
  Lose = -1
  Draw = 0
end
