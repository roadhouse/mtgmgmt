class CardDeck < ActiveRecord::Base
  belongs_to :card
  belongs_to :deck

  scope :main, -> { where(part: :main) }
  scope :sideboard, -> { where(part: :sideboard) }

  validates_presence_of :card, :copies
end
