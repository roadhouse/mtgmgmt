require "postgres_ext"

require_dependency "card_param"
require_dependency "deck_param"
require_dependency "inventory_param"
require_dependency "param_builder"

class Orthanc
  def initialize(options = nil)
    default_options = {
      limit: 10,
      season: "BFZ-DTK-FRF-KTK-ORI",
      part: "main"
    }

    @options = default_options.merge ParamBuilder.params(options.to_s)

    @card = CardParam.new(@options)
    @deck = DeckParam.new(@options)
  end

  # basic card search using CardParam params as filter
  def cards
    @options.empty? ? @card.table.none : @card.table.where(@card.params)
  end

  # top cards played in standard
  # DEFAULT: looking in main deck and ignore land cards
  def top_cards
    presence_on_field = "(cast(card_quantity.quantity as float) /
      cast((#{@deck.total_decks.to_sql}) as float)) * 100 AS presence"

    @card.table
      .with(@deck.card_totals)
      .select(@card.all_fields, presence_on_field)
      .joins("INNER JOIN card_quantity ON card_quantity.name = cards.name")
      .where(@card.params).where(@card.not_lands)
      .order("card_quantity.quantity DESC")
      .limit(@options.fetch(:limit))
  end

  #  top cards played in standard, in the last season
  def top_decks
    @deck.table
      .select("name, COUNT(decks.list->'main_cards') AS quantity")
      .group(@deck.name)
      .order("COUNT(decks.list->'main_cards') DESC")
      .where(@deck.params)
      .limit(@options.fetch(:limit))
  end

  def from_user(user, inventory_filters = nil)
    card_filters = @card.table.where(@card.params).order(price: :desc)
    inventory = inventory_filters ? InventoryParam.new(inventory_filters).params : inventory_filters

    user.inventories.where(inventory).joins(:card).merge(card_filters)
  end
end
