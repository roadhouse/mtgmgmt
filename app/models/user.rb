class User < ActiveRecord::Base
  attr_accessible :login

  has_many :invetories
  has_many :cards, through: :inventories
end
