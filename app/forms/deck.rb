class Deck
  include Virtus
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attribute :id, Integer
  attribute :name, String
  attribute :description, String
  attribute :card_list, String

  def persisted?
    true
  end
end
