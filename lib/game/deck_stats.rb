class DeckStats
  TYPES =  {land: /Land/, instant: /Instant/, sorcery: /Sorcery/, enchantment: /Enchantment/, planeswalker: /Planeswalker/, creature: /Creature/, artifact: /Artifact/}

  # [Card, Card]
  def initialize(deck)
    @deck = deck
  end

  def lands
    grouped_by(:land)
  end

  def non_lands
    @deck.find_all {|i| !i.ctype.match(TYPES[:land])}
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
end
