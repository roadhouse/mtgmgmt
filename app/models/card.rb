class Card < ActiveRecord::Base
  scope :per_name, ->(name) { where(["name ilike ?", "%#{name}%"]) }
  scope :per_type, ->(type) { where(["ctype ilike ?", "%#{type}%"]) }

  validates_presence_of :name

  has_many :card_decks
  has_many :inventories
  has_many :users, through: :inventories
  has_many :prices
  
  def self.find_by_name!(name)
    per_name(name).first or Card.create!(name: name, set: :fake)
  end

  def on_demand_price
    if price_updated_at.nil? or price_updated_at < 7.day.ago
      Delayed::Job.enqueue CardPricerJob.new(self.id)
    end

    self.price
  end
end
