class Deck < ActiveRecord::Base
  has_many :card_decks
  has_many :cards, through: :card_decks

  validates_uniqueness_of :url

  def add_card(copies, name, part)
    card_decks.build(card: Card.per_name(name).first, copies: copies, part: part)
  end

  def main
    card_list_from(:main)
  end

  def sideboard
    card_list_from(:sideboard)
  end

  private

  def card_list_from(part)
    card_decks.where(part: part).map do |entry| 
      { copies: entry.copies, card: entry.card }
    end
  end
end
