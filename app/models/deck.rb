class Deck < ActiveRecord::Base
  # serialize :list, LoadCards
  paginates_per 10

  scope :per_name, ->(name) { where(arel_table[:name].matches("%#{name}%")) }

  validates_uniqueness_of :url

  def table
    Deck.arel_table
  end

  def archeptype_deck
    Deck.where(table[:name].matches(name)).last
  end

  def cards
    Card.where(name: (list["main"].keys + list["sideboard"].keys).uniq)
  end

  def main
    for_game(:main)
  end

  def sideboard
    for_game(:sideboard)
  end

  def add_card_entries(entries)
    tap do |deck|
      list = entries.map { |entry| [Card.find(entry.first).name, entry.last] }

      deck.list = {main: Hash[list]}
    end
  end

  def only_cards_list(part = :main)
    list[part.to_s].keys.sort.join("::")
  end

  def season_tag
    cards
      .pluck(:set)
      .compact
      .uniq
      .delete_if { |i| i == "fake" }
      .sort
      .join("-")
  end

  def update_meta_data
    update season: season_tag, list: list.merge(main_cards: only_cards_list)
  end

  private

  def for_game(part)
    list[part.to_s].to_h.flat_map do |entry|
      name, copies = entry

      Array.new(copies.to_i) { Card.find_by_name name.gsub(/AEther|Aether/, "Æther") }
    end
  end
end
