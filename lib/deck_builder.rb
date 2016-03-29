class DeckBuilder
  def initialize(params)
    @deck = Deck.new params
  end

  def build
    @deck.tap do |deck|
      deck.save!
      deck.update_meta_data
    end
  end
end
