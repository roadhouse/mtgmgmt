class Mana
  def initialize(cost)
    @mana_cost = cost.to_s
  end

  def manas
    @mana_cost
      .gsub(/{|}/,"")
      .chars
      .map { |i| ManaCost.new(i) }
  end

  def colors
    manas.map(&:color)
  end

  def black
    manas.all {|mana| mana.black?}
  end

  def red
    manas.all {|mana| mana.red?}
  end

  def blue
    manas.all {|mana| mana.blue?}
  end

  def green
    manas.all {|mana| mana.green?}
  end

  def white
    manas.all {|mana| mana.white?}
  end

  def colorless
    manas.all {|mana| mana.colorless?}
  end

  def converted_manacost
    manas.map(&:value).sum
  end

  def colored?
    manas.map(&:colored?).any? {|mana| mana.colored? == true}
  end

  def colorless?
    manas.map(&:colorless?).all? {|mana| mana.colorless? == true}
  end
end
