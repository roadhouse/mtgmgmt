class Card < ActiveRecord::Base
  attr_accessible :set, :name, :card_type

  scope :per_name, ->(name) { where(["name ilike ?", "%#{name}%"]) }
  validates_presence_of :set, :name, :card_type

  has_many :inventories
  has_many :users, through: :inventories
end
