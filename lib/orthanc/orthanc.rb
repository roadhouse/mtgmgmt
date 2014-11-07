class Orthanc
  #.new(color: :w, type: :c, part: :m)
  def initialize(options={})
    @options = options

    @options[:limit] = 10
    @c = CardParam.new(@options)
    @cd = CardDeckParam.new(@options)
  end

  def cards
    Card.where(@c.params)
  end

  def top_cards
    Card.joins(:card_decks)
      .select(:id, :name, @c.count_name.as("quantity"))
      .where(@c.params.and(@cd.params))
      .group(@c.name, @c.id)
      .order(@c.count_name.desc)
      .limit(@options[:limit])
  end
end

class CardDeckParam
  def initialize(options={})
    @options = options
  end

  def params
    p = {m: :main, s: :sideboard}

    part = p[@options.fetch(:part) { :m }]

    where = deck_part_is(part)

    where
  end

  def table
    CardDeck.arel_table
  end

  def deck_part_is(part)
    table[:part].eq(part)
  end
end

class CardParam
  def initialize(options)
    @options = options 
  end

  def params
    c = {w: "White", u: "Blue", b: "Black", r: "Red", g: "Green"}
    t = {c: "Creature", l: "Land", i: "Instant", s: "Sorcery", e: "Enchantment", p: "Planeswalker", a: "Artifact", nl: :nonland}

    color = c[@options[:color]]
    type = t[@options[:type]]

    where = not_lands
    where = where.send(:and, card_type_is(type)) if type
    where = where.send(:and, card_color_is(color)) if color

    where
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
end

class QueryParam
  def initialize(options)
    @options = options 
  end

  def params
    c = {w: "White", u: "Blue", b: "Black", r: "Red", g: "Green"}
    t = {c: "Creature", l: "Land", i: "Instant", s: "Sorcery", e: "Enchantment", p: "Planeswalker", a: "Artifact", nl: :nonland}
    p = {m: :main, s: :sideboard}

    color = c[@options[:color]]
    type = t[@options[:type]]
    part = p[@options.fetch(:part) { :m }]

    where = deck_part_is(part)

    where = type ? where.send(:and, card_type_is(type)) : where.send(:and, not_lands)
    where = where.send(:and, card_color_is(color)) if color

    where
  end

  def not_lands
    card[:ctypes].not_in("{Land}")
  end

  def deck_part_is(part)
    deck[:part].eq(part)
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

  def deck
    CardDeck.arel_table
  end

  def id
    card[:id]
  end

  def name
    card[:name]
  end
end
