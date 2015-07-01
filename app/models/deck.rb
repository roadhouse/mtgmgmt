class LoadCards
  def self.dump(hash)
    hash.each_with_object({}) do |value, memo|
      quantities = value.last.map { |c| [c.name, value.last.count {|c1| c1.name == c.name}] }

      memo[value.first] = Hash[quantities]
    end.to_json
  end

  def self.load(hash)
    if hash
      hash.each_with_object({}) do |part, list|
        part_name = part.first
        card_list = part.last

        list[part_name] = card_list.flat_map { |e| Array.new(e.last.to_i) { |_| Card.find_or_initialize_by(name: e.first) } }
      end
    else
      {}
    end.with_indifferent_access
  end
end

class Deck < ActiveRecord::Base
  # serialize :list, LoadCards
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

