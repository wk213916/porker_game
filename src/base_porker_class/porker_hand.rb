module Suit
  Spade = { picture: "♤" }
  Clover = { picture: "♧" }
  Heart = { picture: "♡" }
  Diamond = { picture: "♤" }
end

module RankPicture
  J = 11.freeze
  Q = 12.freeze
  K = 13.freeze
  A = 1.freeze
end

module CardRank
  RankA = {rank: RankPicture::A, score:14}
  Rank2 = {rank: 2, score: 2}
  Rank3 = {rank: 3, score: 3}
  Rank4 = {rank: 4, score:4}
  Rank5 = {rank: 5, score:5}
  Rank6 = {rank: 6, score:6}
  Rank7 = {rank: 7, score:7}
  Rank8 = {rank: 8, score:8}
  Rank9 = {rank: 9, score:9}
  Rank10 = {rank: 10, score:10}
  RankJ = {rank: RankPicture::J, score:11}
  RankQ = {rank: RankPicture::Q, score:12}
  RankK = {rank: RankPicture::K, score:13}

  AllRank = [RankA, Rank2, Rank3, Rank4, Rank5, Rank6, Rank7, Rank8, Rank9, Rank10, RankJ, RankQ, RankK]
end

module TwoPorkerCardHandRole
  HighCard = { name: "ハイカード", score: 0 }.freeze
  Flash = { name: "フラッシュ", score: 1 }.freeze
  Straight = { name: "ストレート", score: 2 }.freeze
  Pair = { name: "ペア", score: 3 }.freeze
  StraightFlash = { name: "ストレートフラッシュ", score: 4 }.freeze
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
