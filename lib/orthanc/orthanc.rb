class Orthanc
  def initialize(cards)
    @card = cards
  end

  def most_playable_cards
    quantity = "count(card_id) as quantity"
    more_playable_to_less = "quantity desc"

    @cards
      .select(:card_id, :part, quantity)
      .group(:part, :card_id)
      .order(more_playable_to_less)
  end
end
