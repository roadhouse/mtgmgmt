class Card < ActiveRecord::Base
  scope :per_name, ->(name) { where(["name ilike ?", "%#{name}%"]) }
  scope :per_type, ->(type) { where(["ctype ilike ?", "%#{type}%"]) }
  validates_presence_of :name

  has_many :card_decks
  has_many :inventories
  has_many :users, through: :inventories
  
  def self.find_by_name!(name)
    per_name(name).first or Card.create!(name: name, set: :fake)
  end

  def on_demand_price
    unless price
      self.update_attribute(:price, CardPricer.new(self.name).price)
    end

    price
  end
end
