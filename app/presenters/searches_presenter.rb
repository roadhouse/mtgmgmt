class SearchesPresenter < BasePresenter
  delegate :power, :toughness, :name, :manacost, :text,  to: :"@subject"

  # FIXME remove this dependency
  def card_deck
    CardDeck.new(card: @subject)
  end

  def body
    toughness.nil? ? [] : "creature"
  end

  # FIXME remove this dependency
  def avaiable_decks
    Deck.all.map { |d| [d.name, d.id] }
  end
end
