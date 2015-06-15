class DeckParam < BaseParam
  ar_model Deck
  db_fields :id, :name, :season

  def initialize(options)
    @options = options 
  end

  def season_is(str)
    season.eq(str)
  end

  def name_quantity
    name.count.as("quantity")
  end

  def total_decks
    table.select(name_quantity)
  end

  def cards_on_deck
    table.select("jsonb_object_keys(list->'main') AS name")
      .where(season_is(@options.fetch(:season)))
  end

  def params 
    season_is @options.fetch(:season)
  end
end
