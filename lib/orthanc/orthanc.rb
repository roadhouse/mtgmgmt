require 'deck_param.rb'
#centralize queries (using arel) and extract reports
# PARAMS: {color: [:w|:r|:c|:b|:a|:g], type: [:a|:l|:i|:s|:c|:p], part: [:m|:s]}
class Orthanc
  def initialize(options)
    @options = options

    @c = CardParam.new(@options)
    @d = DeckParam.new
  end

  #basic card search using CardParam params as filter
  def cards
    if @options.empty?
      @c.model.none
    else
      @c.model.where(@c.params)
    end
  end

  def cards_on_deck
    @d.model
      .select("jsonb_object_keys(list->'main') AS name")
      .where(season: "BNG-DTK-FRF-JOU-KTK-M15-THS")
  end

  def total_decks
    @d.model.select @d.name.count.as("total_decks")
  end

  def top_cards_cte
    sql = %{
      SELECT cards_on_deck.name, count(cards_on_deck.name) AS total_card, total_decks.total_decks AS field
      FROM cards_on_deck, total_decks
      GROUP BY cards_on_deck.name, total_decks
    }

    Arel.sql(sql);
  end

  def top2 
    require 'postgres_ext'
    @c.model
      .with(cards_on_deck: cards_on_deck, total_decks: total_decks, top_cards_cte: top_cards_cte)
      .joins("INNER JOIN top_cards_cte ON top_cards_cte.name = cards.name")
      .where(@c.params)
      .order("top_cards_cte.total_card DESC")
      .limit(10)
  end

  #top cards played in standard
  #DEFAULT: looking in main deck and ignore land cards
  def top_cards
    sql = %{
      WITH cards_on_deck AS (
        SELECT jsonb_object_keys(list->'main') AS name
        FROM decks
        WHERE decks.season = 'BNG-DTK-FRF-JOU-KTK-M15-THS'  
      ), total_decks AS (
        SELECT COUNT(*) AS total_decks
        FROM decks
      ), top_cards AS (
        SELECT cards_on_deck.name, count(cards_on_deck.name) AS total_card, total_decks.total_decks AS field
        FROM cards_on_deck, total_decks
        GROUP BY cards_on_deck.name, total_decks
      )

      SELECT *, (cast(total_card as float) / cast(field as float)) * 100 AS percent
      FROM cards
      INNER JOIN top_cards
      ON top_cards.name = cards.name
      WHERE #{@c.params.to_sql}
      ORDER BY top_cards.total_card DESC
      LIMIT 10;
    }

    @c.model.find_by_sql(sql)
  end

  def top_decks
    @d.model
      .select(@d.name, @d.name.count.as("quantity"))
      .group(@d.name)
      .order(Arel::Nodes::Descending.new(@d.name.count))
      .where(@d.season.eq("BNG-DTK-FRF-JOU-KTK-M15-THS"))
      .limit(@options.fetch(:limit) {10})
  end
end

# cards table wrapper
# PARAMS: {type: [:a|:l|:i|:s|:c|:p], color: [:r|:w|:b|:u|:g], name: "Black Lotus"}
# when name was passed the the scope the query included lands
class CardParam
  def initialize(options)
    @options = options 
  end

  def params
    c = {w: "White", u: "Blue", b: "Black", r: "Red", g: "Green"}
    t = {c: "Creature", l: "Land", i: "Instant", s: "Sorcery", e: "Enchantment", p: "Planeswalker", a: "Artifact"}

    color = c[@options[:color]]
    type = t[@options[:type]]
    name = @options[:name].to_s
    oracle = @options[:oracle]

    where = name.empty? ? not_lands : card_name_is(name)

    where = where.and(card_type_is(type))   if type
    where = where.and(card_color_is(color)) if color
    where = where.and(oracle_contains(oracle)) if oracle

    where
  end

  def oracle_contains(text)
    card[:original_text].matches("%#{text}%")
  end

  def card_name_is(name)
    match = "%#{name}%" 
    card[:name].matches(match).or(card[:portuguese_name].matches(match))
  end

  def not_lands
    card[:ctypes].not_in("{Land}")
  end

  def card_type_is(type)
    card[:ctypes].in("{#{type}}")
  end

  def card_color_is(color)
    card[:colors].in("{#{color}}")
  end

  def count_name
    card[:name].count
  end

  def card
    Card.arel_table
  end

  def id
    card[:id]
  end

  def name
    card[:name]
  end

  def image
    card[:image]
  end

  def price
    card[:price]
  end

  def price_updated_at
    card[:price_updated_at]
  end

  def updated_at
    card[:updated_at]
  end

  def model
    Card
  end
end
