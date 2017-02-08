class DeckBuilder
  def initialize(params)
    @deck = Deck.new params
  end

  def build
    @deck.tap do |deck|
      daily_id = deck.description[/#\d*/]

      if daily_id && mtgo_deck_exists?(daily_id)
        fail Laracna::DuplicateDeckError, deck[:url]
      else
        deck.save!
        deck.update_meta_data
      end
    end
  end

  def mtgo_deck_exists?(daily_id)
    Deck
      .where(source: "mtgo")
      .where(Deck.arel_table[:name].matches("%#{daily_id}%"))
      .exists?
  end
end
