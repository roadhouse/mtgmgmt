class Inventory < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :card
  belongs_to :user
  scope :from_list, ->(name) { where(list: name) }
  scope :from_card_list, ->(card_list) { where("card_id in (?)", card_list) }

  def to_deck_array
    Array.new(copies) { card_id }
  end
end
