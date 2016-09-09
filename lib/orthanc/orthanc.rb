require "postgres_ext"

require_dependency "card_param"
require_dependency "deck_param"
require_dependency "inventory_param"
require_dependency "param_builder"

class Orthanc
  SEASON = "BFZ-DTK-Eldritch Moon-ORI-OWG-SOI"
  DEFAULT_OPTIONS = { limit: 12, season: SEASON, part: "main" }

  def initialize(options = nil)
    @options = DEFAULT_OPTIONS.merge ParamBuilder.params(options.to_s)

    @card = CardParam.new(@options)
    @deck = DeckParam.new(@options)
    @inventory = InventoryParam.new(@options)
  end

  # basic card search using CardParam params as filter
  def cards
    @options.empty? ? @card.table.none : @card.table.where(@card.params)
  end

  # basic card search using CardParam params as filter
  def decks
    @deck.table.where(@deck.params)
  end

  # top cards played in standard
  # DEFAULT: looking in main deck and ignore land cards
  def top_cards
    cards
      .where(@card.not_lands)
      .with(metagame: metagame)
      .joins("INNER JOIN metagame ON metagame.card = cards.name")
      .order("metagame.quantity DESC")
      .limit(@options.fetch :limit)
  end

  # the relation between the decks of the metagame and the card's quantity in this decks
  def metagame
    decks
      .select('count(card) as quantity, card')
      .joins("CROSS JOIN LATERAL jsonb_object_keys(list->'#{@options.fetch :part}') as card")
      .group('card')
  end

  # top decks from a season
  def top_decks
    decks
      .select(@deck.all_fields, "COUNT(decks.list->'main_cards') AS quantity")
      .group(:id)
      .order("COUNT(decks.list->'main_cards') DESC")
      .limit(@options.fetch :limit)
  end

  # list cards from users
  def from_user(user)
    user
      .inventories
      .where(@inventory.params)
      .joins(:card)
      .merge(cards.order price: :desc)
      .limit(@options.fetch :limit)
  end
end
