module Utils
  refine Array do
    def delete_first(item)
      delete_at(index(item) || length)
    end
  end
end

class User < ActiveRecord::Base
  using Utils

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :collections
  has_many :inventories
  has_many :cards, through: :inventories

  def percent_from(cards)
    deck_list = cards.compact.map(&:id)

    card_ids_owned_from(deck_list).each { |card| deck_list.delete_first card }

    calculate_percent_owned deck_list.size, cards.compact.map(&:id).size
  end

  def card_ids_owned_from(card_list)
    # TODO, move this query to a Inventory scope method maybe?
    inventories
      .where(card_id: card_list.uniq, list: :game)
      .flat_map { |i| Array.new(i.copies) { i.card_id } }
  end

  def calculate_percent_owned(remaining_cards, total_cards)
    100.0 - ((remaining_cards.to_f / total_cards.to_f) * 100.0)
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token
      user.avatar = auth.info.image
      user.save!
    end
  end
end
