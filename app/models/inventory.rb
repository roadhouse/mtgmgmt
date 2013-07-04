class Inventory < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :card
  belongs_to :user
end
