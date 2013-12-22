class Deck < ActiveRecord::Base
  has_many :card_decks
  has_many :cards, through: :card_decks

  def add_card_by_name(name, copies)
    card_decks.build(card: Card.per_name(name).first, copies: copies)
  end
end
