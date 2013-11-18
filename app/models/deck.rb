class Deck < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :card_decks
  has_many :cards, through: :card_decks

  def add_card(params)
    name = params.fetch(:name)

    new_params = { card: Card.find_by_name(name) }.merge(params)

    card_decks.build(new_params)
  end
end
