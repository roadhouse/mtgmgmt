class MetaGamePresenter
  def top_cards(params = "")
    Orthanc.new(params).top_cards
  end

  def top_decks
    DeckPresenter.map Orthanc.new("").top_decks.map { |d| d.archeptype_deck }
  end
end

