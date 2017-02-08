class BaseParam
  def initialize(options)
    @options = options 
  end

  def self.model(ar)
    @model = ar
  end

  def self.fields(*args)
    @fields = args
  end

  def table
    self.class.instance_variable_get(:@model)
  end

  def all_fields
    field(Arel.star)
  end

  private

  def self.inherited(subclass)
    subclass.class.instance_variable_set("@model", @ar_model)
    subclass.class.instance_variable_set("@fields", @db_fields)
    super
  end

  def method_missing(method, *args, &block)
    db_fields.include?(method) ? field(method) : super
  end

  def field(field)
    table.arel_table[field]
  end

  def db_fields
    self.class.instance_variable_get(:@fields)
  end
end
