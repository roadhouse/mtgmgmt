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

    season = deck.cards.pluck(:set).compact.uniq.delete_if { |i| i == "fake"}.sort.join("-")

    @deck.season = season
  end

  def add_cards_from(part)
    list = @card_list.fetch(part).inject({}) do |m,v|
      m.tap { |hash| hash[v.fetch(:card)] = v.fetch(:copies) }
    end

    @deck.list = { part => list }
  end
end
