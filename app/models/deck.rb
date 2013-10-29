class Deck < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :card_deks
  has_many :cards, through: :card_deks
end
