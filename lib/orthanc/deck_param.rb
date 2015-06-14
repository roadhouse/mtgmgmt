class DeckParam
  def initialize(options)
    @options = options 
  end

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

  def season
    table[:season]
  end

  def season_is(str)
    season.eq(str)
  end

  def name_quantity
    name.count.as("quantity")
  end

  def total_decks
    model.select(name_quantity)
  end

  def cards_on_deck
    model.select("jsonb_object_keys(list->'main') AS name")
      .where(season_is(@options.fetch(:season)))
  end

  def params 
    season_is @options.fetch(:season)
  end
end
