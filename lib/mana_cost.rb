class ManaCost
  def initialize(mana_cost)
    @mana_cost = mana_cost
  end

  def value
    colored_manacost = @mana_cost.match(/{(\D)}/)
    colorless_manacost = @mana_cost.match(/{(\d)}/)

    value = (colored_manacost or colorless_manacost).captures.first.to_i

    value.zero? ? 1 : value
  end

  def colored?
    [black?, red?, blue?, green?, white?].any? {|color| color == true}
  end

  def colorless?
    [black?, red?, blue?, green?, white?].all? {|color| color == false}
  end

  def black?
    false
  end
  def red?
    !!@mana_cost.match(/{(\D)}/)
  end
  def blue?
    false
  end
  def green?
    false
  end
  def white?
    false
  end
end
