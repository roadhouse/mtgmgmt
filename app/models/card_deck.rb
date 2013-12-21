class CardDeck < ActiveRecord::Base
  belongs_to :card
  belongs_to :deck

  validates_presence_of :card, :copies
end
