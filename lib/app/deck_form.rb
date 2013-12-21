class BaseForm
  include Virtus.model

  include ActiveModel::Validations
  
  def initialize(model)
    @model = model
  end

  def to_key
    @model.to_key
  end

  def persisted?
    false
  end
end

class DeckForm < BaseForm
  attribute :name, String
  attribute :description, String
  attribute :card_list, String

  validates_presence_of :name, :card_list
  
  def self.model_name
    ActiveModel::Name.new(Deck)
  end
end
