require './lib/game/mana_cost'
class Deck < ActiveRecord::Base
  paginates_per 10

  has_many :card_decks
  has_many :cards, through: :card_decks

  validates_uniqueness_of :url

  def table
    Deck.arel_table
  end

  def archeptype_deck
    Deck.where(table[:name].matches(name)).last
  end

  def add_card(copies, name, part)
    begin
      card_decks.build(card: Card.find_by_name!(name), copies: copies, part: part)
    rescue ActiveRecord::RecordNotFound
      raise name
    end
  end

  def main
    for_game(:main)
  end

  def sideboard
    for_game(:sideboard)
  end


  def card_list_from(part)
    card_decks.where(part: part).map do |entry| 
      { copies: entry.copies, card: entry.card }
    end
  end

  def for_game(part)
    card_list_from(part).map do |card|
      Array.new(card[:copies]) { |_| card[:card] }
    end.flatten
  end

  private

  def group_by_card_type(part)
    data = card_list_from(part).group_by do |deck_entry| 
      deck_entry[:card].ctype.match(/Land|Instant|Sorcery|Enchantment|Planeswalker|Creature|Artifact/).to_s
    end
    
    Hash[data.sort]
  end
end

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
