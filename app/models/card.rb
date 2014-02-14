class Card < ActiveRecord::Base
  scope :per_name, ->(name) { where(["name ilike ?", "%#{name}%"]) }
  validates_presence_of :set, :name, :card_type

  has_many :inventories
  has_many :users, through: :inventories
  
  def self.find_by_name!(name)
    per_name(name).first or raise name
  end
end
