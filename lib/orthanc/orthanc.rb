class Orthanc
  def initialize(cards)
    @cards = cards
  end

  # .test(color: :w, type: :c)
  def teste(p={})
    Card.joins(:card_decks)
      .select(:id, :name, count_name)
      .where(params(p))
      .group(card[:name], card[:id])
      .order("quantity desc")
      .limit(p.fetch(:limit) { 10 })
  end

  def params(hash)
    c = {w: "White", u: "Blue", b: "Black", r: "Red", g: "Green"}
    t = {c: "Creature", l: "Land", i: "Instant", s: "Sorcery", e: "Enchantment", p: "Planeswalker", a: "Artifact", nl: :nonland}
    p = {m: :main, s: :sideboard}

    color = c[hash[:color]]
    type = t[hash[:type]]
    part = p[hash.fetch(:part) { :m }]

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
    card[:name].count.as("quantity")
  end

  def card
    Card.arel_table
  end

  def deck
    CardDeck.arel_table
  end

  def top_creatures
    teste()
  end

  def top_instants
    teste(type: "Instant")
  end
end
