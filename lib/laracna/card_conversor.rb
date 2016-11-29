class CardConversor
  ATTRS_TO_DELETE = %w(foreignNames types rulings legalities variations type text id starter)
  EQUIVALENT_NAMES = {
    ctype: "type",
    image: "imageUrl",
    mana_cost: "manaCost",
    multiverse_id: "multiverseid",
    original_text: "originalText",
    original_type: "originalType",
  }

  def initialize(api_data)
    @api_data = api_data.to_hash
  end

  def self.convert(api_data)
    new(api_data).convert
  end

  def convert
    normalize_data
    delete_fields
  end

  def normalize_data
    @api_data.tap do |data|
      EQUIVALENT_NAMES.each_pair { |ar_field, api_field| data[ar_field] = data.delete api_field }
    end
  end

  def delete_fields
    @api_data.tap { |card| ATTRS_TO_DELETE.map { |attr| card.delete attr } }
  end
end
