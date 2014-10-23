class ManaCost
  def initialize(mana_cost)
    @mana_cost = mana_cost
  end

  def value
    @mana_cost.match(/{(\d)}/).captures.first.to_i
  end
end
