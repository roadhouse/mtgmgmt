class Orthanc
  def initialize(cards)
    @cards = cards
  end

  # .test(color: :w, type: :c)
  def teste(p={limit: 10})
    Card.joins(:card_decks)
      .select(:name, Card.arel_table[:name].count.as("quantity"))
      .where(params(p))
      .group("cards.name")
      .order("quantity desc")
      .limit(p.fetch(:limit) { 10})
  end

  def params(p)
    Hash.new.tap do |where|
      color = p.fetch(:color) {nil}
      part = p.fetch(:part) { :main }
      type = p.fetch(:type) { "Creature"}

      where[:card_decks] = {part: part} if part
      where[:ctypes] = ["{#{type}}"] if type
      where[:colors] = ["{#{color}}"] if color
    end
  end

  def top_creatures
    teste()
  end

  def top_instants
    teste(type: "Instant")
  end
  
  def most_playable_cards(limit = 10)
      query = <<QUERY 
SELECT cards.id, cards.name, count(cards.name) as quantity 
FROM card_decks, cards  
WHERE card_decks.part = 'main' 
AND cards.id = card_decks.card_id
AND 'Land' <> ANY(cards.ctypes)
GROUP BY cards.name, cards.id
ORDER BY quantity desc
limit #{limit}
QUERY

    Card.find_by_sql(query)
  end

  def most_playable_decks(limit = 10)
    Deck.all
      .select(:name,Deck.arel_table[:name].count.as("quantity"))
      .group(:name)
      .order("quantity desc")
      .limit(limit)
  end

  
end
