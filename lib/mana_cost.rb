class ManaCost
  def initialize(mana_cost)
    @mana_cost = mana_cost
  end

  def value
    @mana_cost.match(/{(\d)}/).captures.first.to_i
  end

  def colorless?
    [black?, red?, blue?, green?, white?].all? {|color| color == false}
  end

  def black?
    false
  end
  def red?
    false
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
