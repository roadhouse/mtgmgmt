# PARAMS: {type: [:a|:l|:i|:s|:c|:p], color: [:r|:w|:b|:u|:g], name: "Black Lotus", oracle: "haste"}
# when name was passed the the scope the query included lands
class CardParam
  def initialize(options)
    @options = options 
  end

  def params
    c = {w: "White", u: "Blue", b: "Black", r: "Red", g: "Green"}
    t = {c: "Creature", l: "Land", i: "Instant", s: "Sorcery", e: "Enchantment", p: "Planeswalker", a: "Artifact"}

    color = c[@options[:color]]
    type = t[@options[:type]]
    name = @options[:name].to_s
    oracle = @options[:oracle]

    where = name.empty? ? not_lands : card_name_is(name)

    where = where.and(card_type_is(type))   if type
    where = where.and(card_color_is(color)) if color
    where = where.and(oracle_contains(oracle)) if oracle

    where
  end

  def oracle_contains(text)
    card[:original_text].matches("%#{text}%")
  end

  def card_name_is(name)
    match = "%#{name}%" 
    card[:name].matches(match).or(card[:portuguese_name].matches(match))
  end

  def not_lands
    card[:ctypes].not_in("{Land}")
  end

  def card_type_is(type)
    card[:ctypes].in("{#{type}}")
  end

  def card_color_is(color)
    card[:colors].in("{#{color}}")
  end

  def count_name
    card[:name].count
  end

  def card
    Card.arel_table
  end

  def id
    card[:id]
  end

  def name
    card[:name]
  end

  def image
    card[:image]
  end

  def price
    card[:price]
  end

  def price_updated_at
    card[:price_updated_at]
  end

  def updated_at
    card[:updated_at]
  end

  def model
    Card
  end
end

