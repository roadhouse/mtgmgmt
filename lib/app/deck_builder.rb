class DeckBuilder
  Standard = OpenStruct.new(parts: %i(main sideboard))

  def initialize(format = Standard, params)
    @card_list = DeckListParser.new(params.delete(:card_list)).parse
    @deck = Deck.new(params)
    @format = format
  end

  def build
    @deck.tap do |deck|
      populate

      deck.save!
    end
  end

  private

  def populate
    @format.parts.each { |part| add_cards_from(part) }
  end

  def add_cards_from(part)
    @card_list.fetch(part).each do |attrs| 
      name = attrs.fetch(:name)
      copies = attrs.fetch(:copies)

      @deck.add_card_by_name(name, copies)
    end
  end
end
