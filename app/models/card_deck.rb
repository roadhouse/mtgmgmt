class CardDeck < ActiveRecord::Base
  belongs_to :card
  belongs_to :deck

  scope :main, -> { where(part: :main) }
  scope :sideboard, -> { where(part: :sideboard) }
  scope :from_part, -> (part) { where(part: part) }

  validates_presence_of :card, :copies
end
