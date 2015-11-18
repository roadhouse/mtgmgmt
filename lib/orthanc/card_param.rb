# PARAMS: {type: [:a|:l|:i|:s|:c|:p], color: [:r|:w|:b|:u|:g], name: "Black Lotus", oracle: "haste"}
# when name was passed the the scope the query included lands
class CardParam < BaseParam
  model Card
  fields :original_text, :ctypes, :colors, :name, :portuguese_name, :rarity, :cmc

  def params
    color = @options[:color]
    type = @options[:type]
    name = @options[:name].to_s #default query not nil required
    oracle = @options[:oracle]
    rarity = @options[:rarity]
    cmc = @options[:cmc]

    where = name.empty? ? not_lands : card_name_is(name)

    where = where.and(card_type_is(type))   if type
    where = where.and(card_color_is(color)) if color
    where = where.and(oracle_contains(oracle)) if oracle
    where = where.and(rarity_is(rarity)) if rarity
    where = where.and(cmc_is(cmc)) if cmc

    where
  end

  def cmc_is(value)
    cmc.eq(value)
  end

  def rarity_is(card_rarity)
    rarity.matches("%#{card_rarity}%")
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

