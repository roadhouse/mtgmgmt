class DeckParam < BaseParam
  model Deck
  fields :name, :season

  def season_is(str)
    season.eq(str)
  end

  def name_count
    name.count
  end

  def name_quantity
    name_count.as("quantity")
  end

  def total_decks
    table.select(name_quantity)
  end

  def cards_on_deck
    table.select("jsonb_object_keys(list->'main') AS name")
      .where(season_is(@options.fetch(:season)))
  end

  def card_quantity
    table = Arel::Table.new(:cards_on_deck)
    table
      .project(table[:name], table[:name].count.as('quantity'))
      .group(table[:name])
  end

  def params 
    season_is @options.fetch(:season)
  end
end
