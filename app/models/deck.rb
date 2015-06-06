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
      entries.each_pair do |key, value|
        card = Card.find(key)
        deck.card_decks.build(card: card, copies: value, part: :main)
      end
    end
  end

  private

  def for_game(part)
    card_decks.find_all{|cd| cd.part.to_s == part.to_s}.map do |entry|
      Array.new(entry.copies) { |_| entry.card }
    end.flatten
  end
end
