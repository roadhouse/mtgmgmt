class RepoWrapper
  attr_reader :cards

  def initialize(set)
    @set = set
  end

  def repo
    @cards ||= MTG::Card.where(set: @set).all
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
      data[:mana_cost] = data.delete("manaCost")
      data[:multiverse_id] = data.delete("multiverseid")
      data[:original_text] = data.delete("originalText")
      data[:image] = data.delete("imageUrl")
      data[:original_type] = data.delete("originalType")
      data[:ctypes] = data.delete("types")
    end
  end

  def delete_fields(raw_data)
    x = %w(foreignNames types rulings legalities variations type text id)

    raw_data.tap { |data| x.map { |attr| data.delete attr } }
  end
end
