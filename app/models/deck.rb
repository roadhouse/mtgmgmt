require './lib/game/mana_cost'
class Deck < ActiveRecord::Base
  paginates_per 10

  scope :per_name, ->(name) { where(self.arel_table[:name].matches("%#{name}%")) }

  validates_uniqueness_of :url

  def table
    Deck.arel_table
  end

  def archeptype_deck
    Deck.where(table[:name].matches(name)).last
  end

  def cards
    Card.where(name: (self.list["main"].keys + self.list["sideboard"].keys).uniq)
  end

  def main
    for_game(:main)
  end

  def sideboard
    for_game(:sideboard)
  end

  def add_card_entries(entries)
    self.tap do |deck|
      list = entries.map { |entry| [Card.find(entry.first).name, entry.last] }

      deck.list = { main: Hash[list] }
    end
  end

  private

  def for_game(part)
    list[part.to_s].to_h.flat_map do |entry| 
      card = Card.find_by_name(entry.first)
      Array.new(entry.last.to_i) { |_| card }
    end
  end
end
