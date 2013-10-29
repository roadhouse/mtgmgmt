class DeckFactory
  attr_reader :deck

  def initialize(params)
    @deck = build_deck(params)
  end

  def build_deck(params)
    Deck.new(params)
  end
end
