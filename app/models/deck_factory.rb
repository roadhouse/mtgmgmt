# {
#   main_deck: [
#     {quantity: 4, card_name: "young pyromancer"}
#   ]
#   sideboard: [
#     {quantity: 3, card_name: "wild ricochet"}
#   ]
# }
class DeckFactory
  attr_reader :deck, :main_deck, :sideboard

  def initialize(params)
    @params = params
    @deck = Deck.new
  end

  def build_deck
    @deck.tap do |deck|
      @main_deck = build_main_deck
      @sideboard = build_sideboard

      @deck.save if @deck.valid?
    end
  end

  def build_main_deck
    add_cards_to_deck(:main_deck)
  end
  
  def build_sideboard
    add_cards_to_deck(:sideboard)
  end

  def add_cards_to_deck(collection_name)
    @params.fetch(collection_name).map { |attrs| @deck.add_card_to_deck(attrs) }
  end
end
