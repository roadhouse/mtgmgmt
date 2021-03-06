class Card < ActiveRecord::Base
  scope :per_name, ->(name) { where(["name ilike ?", "%#{name}%"]) }
  scope :per_type, ->(type) { where(["ctype ilike ?", "%#{type}%"]) }

  validates :name, uniqueness: true, presence: true

  has_many :inventories
  has_many :users, through: :inventories
  has_many :prices

  def self.ids_to_name(ids)
    find(ids.uniq).pluck(:name)
  end

  def portuguese_name
    super || name
  end

  def self.find_by_name!(name)
    per_name(name).first || Card.create!(name: name, set: :fake)
  end

  def on_demand_price
    # if price_updated_at.nil? or price_updated_at < 1.day.ago
    #   Delayed::Job.enqueue CardPricerJob.new(self.id)
    # end

    price
  end
end
