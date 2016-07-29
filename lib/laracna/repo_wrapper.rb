class RepoWrapper
  def initialize(set)
    @set = set
  end

  def attributes
    MTG::Card.where(set: @set).all.map do |attributes|
      attrs = attributes.to_hash

      normalize_data attrs
      delete_fields attrs
    end
  end

  def normalize_data(raw_data)
    raw_data.tap do |data|
      equivalent_names.each_pair { |ar_field, api_field| data[ar_field] = data.delete(api_field) }
    end
  end

  def equivalent_names
    {
      mana_cost: "manaCost",
      multiverse_id: "multiverseid",
      original_text: "originalText",
      image: "imageUrl",
      original_type: "originalType",
      ctype: "type",
      set: "setName"
    }
  end

  def attrs_to_delete
    %w(foreignNames types rulings legalities variations type text id)
  end

  def delete_fields(card_attributes)
    card_attributes.tap { |card| attrs_to_delete.map { |attr| card.delete attr } }
  end
end
