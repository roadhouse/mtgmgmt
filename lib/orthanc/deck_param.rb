# decks table wrapper
class DeckParam
  def model
    Deck
  end

  def table
    model.arel_table
  end

  def id
    table[:id]
  end

  def name
    table[:name]
  end
end
