class Beginning
  attr_accessor :deck

  def initialize(deck)
    @deck = deck
  end


end
class Turn
  attr_accessor :phases

  def initialize
    @phases = [Beginning, :precombat_main, :combat, :postcombat_main, :ending]
  end
end
