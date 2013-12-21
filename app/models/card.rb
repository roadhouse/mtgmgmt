class Card < ActiveRecord::Base
  scope :per_name, ->(name) { where(["name ilike ?", "%#{name}%"]) }
  validates_presence_of :set, :name, :card_type

  has_many :inventories
  has_many :users, through: :inventories
end
