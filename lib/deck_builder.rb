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
    @deck.list = {
      main: list_from(:main), 
      sideboard: list_from(:sideboard)
    }

    season = @deck.cards.pluck(:set).compact.uniq.delete_if { |i| i == "fake"}.sort.join("-")
    @deck.season = season
  end

  def list_from(part)
    @card_list.fetch(part).inject({}) do |m,v|
      m[v.fetch(:card)] = v.fetch(:copies)
      m
    end
  end
end
