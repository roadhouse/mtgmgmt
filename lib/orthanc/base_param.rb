class BaseParam
  def self.ar_model(model)
    @@model = model
  end
  def self.db_fields(*fields)
    @@db_fields = fields
  end

  def method_missing(method, *args, &block)
    @@db_fields.include?(method) ? field(method) : super
  end

  def field(field)
    table.arel_table[field]
  end

  def table
    @@model
  end
end
