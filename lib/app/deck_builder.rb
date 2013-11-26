# {
#   main_deck: [
#     {quantity: 4, name: "young pyromancer"}
#   ]
#   sideboard: [
#     {quantity: 3, name: "wild ricochet"}
#   ]
# }
class DeckBuilder
  Standard = OpenStruct.new(parts: %i(main sideboard))

  def initialize(params, format = Standard)
    @params = params
    @format = format
    @deck = Deck.new
  end

  def build
    @deck.tap do |deck|
      populate(deck)

      deck.save!
    end
  end

  private

  def populate(deck)
    @format.parts.each do |part|
      @params.fetch(part).map { |attrs| deck.add_card_by_name(attrs) }
    end
  end
end
