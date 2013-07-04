class CardDeck < ActiveRecord::Base
  attr_accessible :copies, :card, :deck

  belongs_to :card
  belongs_to :deck
end
