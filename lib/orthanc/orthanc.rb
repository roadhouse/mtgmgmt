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
      .with({metagame: metagame})
      .joins("INNER JOIN metagame ON metagame.card = cards.name")
      .where(@card.params).where(@card.not_lands)
      .order("metagame.quantity DESC")
      .limit(@options.fetch(:limit))
  end

  def metagame
    # SELECT count(card) as quantity, card
    # FROM decks
    # CROSS JOIN LATERAL jsonb_object_keys(list->'main') as card
    # WHERE decks.season = 'BFZ-DTK-ORI-OWG-SOI'
    # GROUP BY card

    @deck.table
      .select('count(card) as quantity, card')
      .joins("CROSS JOIN LATERAL jsonb_object_keys(list->'#{@options.fetch(:part)}') as card")
      .where(@deck.params)
      .group('card')
  end

  # top cards played in standard, in the last season
  # find deck by card
  # SELECT *
  # FROM decks
  # CROSS JOIN LATERAL jsonb_object_keys(list->'main') as card
  # where card like 'Ojutai%'
  # GROUP BY id, card
  def top_decks
    @deck.table
      .select(@deck.all_fields, "COUNT(decks.list->'main_cards') AS quantity")
      .group(:id)
      .order("COUNT(decks.list->'main_cards') DESC")
      .where(@deck.params)
      .limit(@options.fetch(:limit))
  end

  # list cards from users
  def from_user(user)
    user.inventories
      .where(@inventory.params)
      .joins(:card)
      .merge(cards.order(price: :desc))
      .limit(@options.fetch(:limit))
  end
end
