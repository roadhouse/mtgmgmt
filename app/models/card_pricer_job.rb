class CardPricerJob < Struct.new(:card_id)
  def perform
    card = Card.find(card_id)
    new_price = CardPricer.new(card.name).price

    if card.price != new_price
      card.prices.build(value: card.price)
      card.price = new_price
      card.price_updated_at = Time.zone.now

      card.save!
    end
  end
end

