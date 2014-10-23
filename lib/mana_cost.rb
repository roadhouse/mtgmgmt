class ManaCost
  def initialize(mana_cost)
    @mana_cost = mana_cost
  end

  def value
    [1, mana_color.to_i].max
  end

  def colored?
    [black?, red?, blue?, green?, white?].any? {|color| color == true}
  end

  def colorless?
    [black?, red?, blue?, green?, white?].all? {|color| color == false}
  end

  def black?
    mana_color == "B"
  end
  def red?
    mana_color == "R"
  end
  def blue?
    mana_color == "U"
  end
  def green?
    mana_color == "G"
  end
  def white?
    mana_color == "W"
  end
  private

  def mana_color
    @mana_cost.match(/{(\D|\d)}/).captures.first
  end
end
