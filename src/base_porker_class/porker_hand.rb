module Suit
  Spade = { picture: "♤", id: 1 }
  Clover = { picture: "♧", id: 2 }
  Heart = { picture: "♡", id: 3 }
  Diamond = { picture: "♤", id: 4 }
end

module RankPicture
  J = 11.freeze
  Q = 12.freeze
  K = 13.freeze
  A = 14.freeze
end

module TwoPorkerCardHandRole
  HighCard = { name: "ハイカード", score: 0, }.freeze
  Flash = { name: "フラッシュ", score: 1}.freeze
  Straight = { name: "ストレート", score: 2}.freeze
  Pair = { name: "ペア", score: 3}.freeze
  StraightFlash = { name: "ストレートフラッシュ", score: 4}.freeze
end

module ThreeCardPorkerHandRole
  HighCard = { name: "ハイカード", score: 0, }.freeze
  Pair = { name: "ペア", score: 1 }.freeze
  Flash = { name: "フラッシュ", score: 2 }.freeze
  Straight = { name: "ストレート", score: 3 }.freeze
  ThreeCard = { name: "スリーカード", score: 4 }
  StraightFlash = { name: "ストレートフラッシュ", score: 5 }.freeze
end

module GameResult
  Win = 1
  Lose = -1
  Draw = 0
  Unknown = -9999
end
