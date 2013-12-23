class Search
  # ActiveModel plumbing
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  include Virtus.model

  attribute :name, String, :default =>  ""

  def execute
    name.empty? ? [] : Card.per_name(name)
  end

  def persisted?
    false
  end
end
