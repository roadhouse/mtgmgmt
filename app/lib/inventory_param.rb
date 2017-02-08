class InventoryParam < BaseParam
  model Inventory

  fields :copies, :list

  def params
    copies = @options[:copies]
    list = @options[:list]

    where = list_is(list.downcase) if list
    where = where ? where.and(copies_less_than(copies)) : copies_less_than(copies) if copies

    where
  end

  def copies_less_than(number)
    copies.lt(number)
  end

  def list_is(list_name)
    list.eq(list_name)
  end
end
