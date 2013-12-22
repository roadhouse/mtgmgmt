class Deck < ActiveRecord::Base
  has_many :card_decks
  has_many :cards, through: :card_decks

  validates_uniqueness_of :url

  def add_card_by_name(name, copies, part)
    card_decks.build(card: Card.per_name(name).first, copies: copies, part: part)
  end
end
