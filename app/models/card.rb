class Card < ActiveRecord::Base
  default_scope { where(is_standard: true) }
  default_scope { where.not(set: :fake) }

  ICON_NAME = {
    KTK: "khans-of-tarkir",
    FRF: "fate-reforged",
    DTK: "dragons-of-tarkir",
    ORI: "magic-origins",
    BFZ: "battle-for-zendikar"
  }

  scope :per_name, ->(name) { where(["name ilike ?", "%#{name}%"]) }
  scope :per_type, ->(type) { where(["ctype ilike ?", "%#{type}%"]) }

  validates :name, 
    uniqueness: true, 
    presence: true

  has_many :inventories
  has_many :users, through: :inventories
  has_many :prices

  def portuguese_name
    super or name
  end
  
  def self.find_by_name!(name)
    per_name(name).first or Card.create!(name: name, set: :fake)
  end

  def on_demand_price
    if price_updated_at.nil? or price_updated_at < 1.day.ago
      Delayed::Job.enqueue CardPricerJob.new(self.id)
    end

    self.price
  end

  # def image
    # if set == "BFZ"
      # "http://ligamagic.com.br/arquivos/up/cartas/images/pt#{number}#{set.downcase}.jpg"
    # else
      # super
    # end
  # end
end
