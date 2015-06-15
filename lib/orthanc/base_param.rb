class BaseParam
  def initialize(options)
    @options = options 
  end

  def self.model(model)
    @@model = model
  end

  def self.fields(*fields)
    @@db_fields = fields
  end

  def table
    @@model
  end

  private

  def method_missing(method, *args, &block)
    @@db_fields.include?(method) ? field(method) : super
  end

  def field(field)
    table.arel_table[field]
  end
end
