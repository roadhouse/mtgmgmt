class DeckStats
  TYPES =  {land: /Land/, instant: /Instant/, sorcery: /Sorcery/, enchantment: /Enchantment/, planeswalker: /Planeswalker/, creature: /Creature/, artifact: /Artifact/}
  COLORS = { red: "{R}", blue: "{U}", green: "{G}", black: "{B}", white: "{W}"}

  # [Card, Card]
  def initialize(deck)
    @deck = deck
  end

  def colored_cost(color)
    @deck
      .map(&:mana_cost).join
      .gsub(non_color, "")
      .split(any_color)
      .delete_if { |entry| entry.empty? }
      .count { |mana| mana == COLORS.fetch(color) }
  end

  def lands
    grouped_by(:land)
  end

  def non_lands
    @deck.find_all {|i| !i.ctype.to_s.match(TYPES[:land])}
  end

  def grouped_by(type)
    type_string = TYPES[type]
    @deck.find_all { |card| card.ctype.match(type_string) }
  end

  def by_manacost
    x=non_lands.group_by {|i| Mana.new(i.mana_cost).converted_manacost }.sort
    Hash[x]
  end

  def by_color
    non_lands
      .map {|i| Mana.new(i.mana_cost).colors}
      .flatten
      .group_by {|i| i}
  end

  def total_by_color
    by_color.inject({}) {|m,v| m[v.first]=v.last.size;m}
  end

  def total_by_manacost
    by_manacost.inject({}) {|m,v| m[v.first]=v.last.size;m}
  end

  def total_by_type
    group_by_card_type.inject({}) {|m,v| m[v.first]=v.last.size;m}
  end

  def group_by_card_type
    data = non_lands.group_by do |card|
      card.ctype.match(/Land|Instant|Sorcery|Enchantment|Planeswalker|Creature|Artifact/).to_s
    end.sort

    Hash[data]
  end

  private

  def any_color
    Regexp.new("(#{COLORS.values.join("|")})")
  end

  def non_color
    /({\d}|{X})/
  end
end
