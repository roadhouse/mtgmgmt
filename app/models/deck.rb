require './lib/game/mana_cost'
class Deck < ActiveRecord::Base
  paginates_per 10

  scope :per_name, ->(name) { where(self.arel_table[:name].matches("%#{name}%")) }

  has_many :card_decks, dependent: :destroy
  has_many :cards, through: :card_decks, dependent: :destroy

  validates_uniqueness_of :url

  def table
    Deck.arel_table
  end

  def archeptype_deck
    Deck.where(table[:name].matches(name)).last
  end

  #using by crawler
  #move
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
      Array.new(entry.last) { |_| card }
    end
  end
end
