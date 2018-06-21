module RankPicture
  A = 1.freeze
  J = 11.freeze
  Q = 12.freeze
  K = 13.freeze
end

module Hand
  HighCard = {name: "ハイカード", score: 0}.freeze
  Pair = {name: "ペア", score: 1}.freeze
  Flash = {name: "フラッシュ", score: 2}.freeze
  Straight = {name: "ストレート", score: 3}.freeze
  StraightFlash = {name: "ストレートフラッシュ", score: 4}.freeze
end
