class Orthanc
  #.new(color: :w, type: :c, part: :m)
  def initialize(options={})
    @options = {limit: 10}.merge(options)
    
    @c = CardParam.new(@options)
    @cd = CardDeckParam.new(@options)
    @d = DeckParam.new
  end

  def cards
    Card.where(@c.params)
  end

  def top_cards
    Card.joins(:card_decks)
      .select(@c.id, @c.name, @c.count_name.as("quantity"))
      .where(@c.params.and(@cd.params))
      .group(@c.name, @c.id)
      .order(@c.count_name.desc)
      .limit(@options[:limit])
  end

  def top_decks
    Deck.select(@d.name, @d.name.count.as("quantity"))
      .group(@d.name)
      .order(@d.name.count.desc)
      .limit(@options[:limit])
  end
end

class DeckParam
  def table
    Deck.arel_table
  end

  def name
    table[:name]
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
    t = {c: "Creature", l: "Land", i: "Instant", s: "Sorcery", e: "Enchantment", p: "Planeswalker", a: "Artifact"}

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
