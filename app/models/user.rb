class User < ActiveRecord::Base
  has_many :inventories
  has_many :cards, through: :inventories

  def percent_from(cards_ids)
    card_user_ids = self.inventories.where(card_id: cards_ids).pluck(:id)

    (cards_ids.sizem/ card_user_ids.size) * 100
  end
end
