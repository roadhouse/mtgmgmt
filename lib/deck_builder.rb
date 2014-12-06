class DeckBuilder
  Standard = OpenStruct.new(parts: %i(main sideboard))

  def initialize(format = Standard, params)
    @card_list = params.delete(:card_list)
    @deck      = Deck.new(params)
    @format    = format
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
      name   = attrs.fetch(:card)
      copies = attrs.fetch(:copies)

      @deck.add_card(copies, name, part)
    end

  end
end
