# PARAMS: {type: [:a|:l|:i|:s|:c|:p], color: [:r|:w|:b|:u|:g], name: "Black Lotus", oracle: "haste"}
# when name was passed the the scope the query included lands
class CardParam < BaseParam
  model Card
  fields :original_text, :ctypes, :colors, :name, :portuguese_name

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
    original_text.matches("%#{text}%")
  end

  def card_name_is(str)
    match = "%#{str}%" 
    name.matches(match).or(portuguese_name.matches(match))
  end

  def not_lands
    ctypes.not_in("{Land}")
  end

  def card_type_is(type)
    ctypes.in("{#{type}}")
  end

  def card_color_is(color)
    colors.in("{#{color}}")
  end

  def count_name
    name.count
  end
end

