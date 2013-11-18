# {
#   main_deck: [
#     {quantity: 4, name: "young pyromancer"}
#   ]
#   sideboard: [
#     {quantity: 3, name: "wild ricochet"}
#   ]
# }
class DeckFactory
  attr_reader :deck, :main, :sideboard

  def initialize(params)
    @params = params
    @deck = Deck.new
  end

  def build_deck
    @deck.tap do |deck|
      add_cards_from(:main)
      add_cards_from(:sideboard)

      deck.save if deck.valid?
    end
  end

  def add_cards_from(group_name)
    @params.fetch(group_name).map { |attrs| @deck.add_card(attrs) }
  end
end
