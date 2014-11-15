#centralize queries (using arel) and extract reports
# PARAMS: {color: [:w|:r|:c|:b|:a|:g], type: [:a|:l|:i|:s|:c|:p], part: [:m|:s]}
class Orthanc
  def initialize(options={})
    @options = {limit: 10}.merge(options)
    
    @c = CardParam.new(@options)
    @cd = CardDeckParam.new(@options)
    @d = DeckParam.new
  end

  #basic card search using CardParam params as filter
  def cards
    @c.model.where(@c.params)
  end

  #top cards played in standard
  #DEFAULT: looking in main deck and ignore land cards
  def top_cards
    @c.model.joins(:card_decks)
      .select(@c.id, @c.name, @c.count_name.as("quantity"))
      .where(@c.params.and(@cd.params))
      .group(@c.name, @c.id)
      .having(@c.not_lands)
      .order(@c.count_name.desc)
      .limit(@options[:limit])
  end

  def top_decks
    @d.model.select(@d.name, @d.name.count.as("quantity"))
      .group(@d.name)
      .order(@d.name.count.desc)
      .limit(@options[:limit])
  end
end

# decks table wrapper
class DeckParam
  def table
    Deck.arel_table
  end

  def id
    table[:id]
  end

  def name
    table[:name]
  end

  def model
    Deck
  end
end

# card_decks table wrapper
# FIXME change table name do deck_entry
# PARAMS: {color: [:w|:r|:c|:b|:a|:g], type: [:a|:l|:i|:s|:c|:p]}
class CardDeckParam
  def initialize(options={})
    @options = options
  end

  def params
    p = {m: :main, s: :sideboard}

    part = p[@options.fetch(:part) { :m }]

    deck_part_is(part)
  end

  def table
    CardDeck.arel_table
  end

  def deck_part_is(part)
    table[:part].eq(part)
  end
end

# cards table wrapper
# PARAMS: {type: [:a|:l|:i|:s|:c|:p], color: [:r|:w|:b|:u|:g]}
class CardParam
  def initialize(options)
    @options = options 
  end

  def params
    c = {w: "White", u: "Blue", b: "Black", r: "Red", g: "Green"}
    t = {c: "Creature", l: "Land", i: "Instant", s: "Sorcery", e: "Enchantment", p: "Planeswalker", a: "Artifact"}

    color = c[@options[:color]]
    type = t[@options[:type]]
    name = t[@options[:name]]

    where = not_lands

    where = where.and(card_type_is(type))   if type
    where = where.and(card_color_is(color)) if color
    where = where.and(card_name_is(name))   if name

    where
  end

  def card_name_is(name)
    card[:name].matches(name).or(card[:portuguese_name].matches(name))
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

  def model
    Card
  end
end
