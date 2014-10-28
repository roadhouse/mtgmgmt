class BoarState

end

class Game
  def initialize(deck)
    @deck = deck
  end

  def begin
    @deck.shuffle
    initial_draw
  end

  def play
    while draw = @deck.pop do
      @hand.push draw
    end
  end

  def initial_draw
    @hand.draw @deck.pop(7)
  end

  def draw(card)
    @hand.push card
  end
end

class GoldFish
  def initialize(deck)
    @deck = deck
  end


  def run
    Game.new(deck).begin
    [BoarState.new]
  end
end
