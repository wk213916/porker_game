require_relative "porker_hand"
require_relative "card.rb"

class Deck
  attr_reader :deck_cards, :porker_hand_num
  def initialize(hand_count:)
    @porker_hand_num = hand_count
    @deck_cards = []
    build_deck!

  end

  def build_deck!
    [Suit::Spade, Suit::Clover, Suit::Heart, Suit::Diamond].each do |suit|
      (1..13).each do |rank|
        deck_cards << Card.new(suit, rank)
      end
    end
    deck_cards.shuffle!
  end

  def deal_cards
    raise NoCardsError.new if deck_cards.length < porker_hand_num
    deck_cards.shift(porker_hand_num)
  end

end

class NoCardsError < StandardError
end
