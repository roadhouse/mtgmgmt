class User < ActiveRecord::Base
  has_many :invetories
  has_many :cards, through: :inventories
end
