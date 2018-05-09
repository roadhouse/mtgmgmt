class CardConversor
  ATTRS_TO_DELETE = %i(id mciNumber watermark variations)
  EQUIVALENT_NAMES = {
    color_identity: :colorIdentity,
    image: :imageName,
    mana_cost: :manaCost,
    multiverse_id: :multiverseid,
    original_text: :text,
    original_type: :type,
    ctypes: :types,
  }

  def initialize(api_data)
    @api_data = api_data
  end

  def self.convert(api_data)
    new(api_data).convert
  end

  def convert
    normalize_data
    delete_fields.merge(is_standard: true)
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
