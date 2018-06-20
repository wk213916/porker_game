class Card
  def initialize(suit,rank)
    @suit = suit
    @rank = rank
    puts "#{@rank}#{@suit}"
  end
end

Card.new("♠︎", "3")
Card.new("♡", "J")
