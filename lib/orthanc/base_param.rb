class BaseParam
  def initialize(options)
    @options = options 
  end

  def table
    raise "implement me"
  end

  def db_fields
    raise "implement me"
  end

  private

  def method_missing(method, *args, &block)
    db_fields.include?(method) ? field(method) : super
  end

  def field(field)
    table.arel_table[field]
  end
end
