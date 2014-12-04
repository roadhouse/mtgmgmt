class User < ActiveRecord::Base
  has_many :inventories
  has_many :cards, through: :inventories

  def percent_from(cards)
    cards_ids = cards.map(&:id)
    card_user_ids = self.inventories.where(card_id: cards_ids).pluck(:id)

    (card_user_ids.size.to_f/cards_ids.size.to_f ) * 100
  end
end
