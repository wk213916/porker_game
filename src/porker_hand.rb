module RankPicture
  J = 11.freeze
  Q = 12.freeze
  K = 13.freeze
  A = 14.freeze
end

module HandCombination
  HighCard = {name: "ハイカード", score: 0, }.freeze
  Flash = {name: "フラッシュ", score: 1}.freeze
  Straight = {name: "ストレート", score: 2}.freeze
  Pair = {name: "ペア", score: 3}.freeze
  StraightFlash = {name: "ストレートフラッシュ", score: 4}.freeze
end

module GameResult
  Win = 1
  Lose = -1
  Draw = 0
end
