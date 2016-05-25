require "postgres_ext"

require_dependency "card_param"
require_dependency "deck_param"
require_dependency "inventory_param"
require_dependency "param_builder"

class Orthanc
  SEASON = "BFZ-DTK-ORI-OWG-SOI"

  def initialize(options = nil)
    default_options = {
      limit: 12,
      season: SEASON,
      part: "main"
    }

    @options = default_options.merge ParamBuilder.params(options.to_s)

    @card = CardParam.new(@options)
    @deck = DeckParam.new(@options)
    @inventory = InventoryParam.new(@options)
  end

  # basic card search using CardParam params as filter
  def cards
    @options.empty? ? @card.table.none : @card.table.where(@card.params)
  end

  # top cards played in standard
  # DEFAULT: looking in main deck and ignore land cards
  def top_cards
    @card.table
      .with(@deck.card_totals)
      .select(@card.all_fields, @deck.presence_on_field)
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

  def from_user(user)
    user.inventories
      .where(@inventory.params)
      .joins(:card)
      .merge(cards.order(price: :desc))
  end
end
