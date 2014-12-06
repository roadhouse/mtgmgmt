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

  private

  def for_game(part)
    card_decks.from_part(part).map do |entry|
      Array.new(entry.copies) { |_| entry.card }
    end.flatten
  end
end
