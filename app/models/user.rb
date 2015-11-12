class User < ActiveRecord::Base
  has_many :collections
  has_many :inventories
  has_many :cards, through: :inventories

  def percent_from(cards)
    cards_ids = cards.compact.map(&:id)
    card_user_ids = self.inventories.where(card_id: cards_ids).pluck(:id)

    (card_user_ids.size.to_f/cards_ids.size.to_f ) * 100
  end

  def percent_from2(cards)
    deck_list = cards.map(&:name)
    pool = collections.where(name: "game").last
      .list.each_with_object({}) { |e, o| o[e.first] = e.last["total"] }
      .flat_map {|e| Array.new(e.last) { |_| e.first  } }

    cards_from_deck_owned = deck_list.select { |p| pool.include?(p) }
    (cards_from_deck_owned.size.to_f / deck_list.size.to_f ) * 100
  end
end
