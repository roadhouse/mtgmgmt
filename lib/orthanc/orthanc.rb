class Orthanc
  def initialize(cards)
    @cards = cards
  end

  def most_playable_cards(limit = 20)
    lands_ids             = Card.per_type("land").map(&:id)
    more_playable_to_less = "quantity desc"
    quantity              = "count(card_id) as quantity"

    @cards
      .select(:card_id, :part, quantity)
      .group(:part, :card_id)
      .order(more_playable_to_less)
      .having('card_id not in (?)', lands_ids)
      .limit(limit)
  end

  def most_playable_decks(limit = 15)
    more_playable_to_less = "quantity desc"
    quantity              = "count(name) as quantity"
    Deck.all
      .select(:name, quantity)
      .group(:name)
      .order(more_playable_to_less)
      .limit(limit)
  end
end
