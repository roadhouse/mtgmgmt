class Engine
  def initialize(zones)
    @zones = zones
  end

  def grimoire
    @zones[:grimoire].cards
  end

  def hand
    @zones[:hand].cards
  end

  def graveyard
    @zones[:graveyard].cards
  end
  
  def battlefield
    @zones[:battlefield].cards
  end
  
  def run!
    turn = 0

    shuffle
    draw(7)

    while !grimoire.empty?
      turn += 1

      draw(1)
      play_land

      discard([hand.first]) if hand.size > 7

      p "TURNO #{turn}: mao -> #{hand.map(&:name).join(', ')}"
      p "TURNO #{turn}: battlefield -> #{battlefield.map(&:name).join(', ')}"
    end
  end

  private

  def shuffle
    grimoire.shuffle!
  end

  def draw(quantity)
    grimoire.pop(quantity).each {|c| hand.push(c)}
  end
  
  def discard(cards)
    cards.each { |card| hand.delete(card); graveyard.push(card) } 
  end

  def play_land
    land = hand.find_all {|card| card.card_type.match("Land") }.first

    if land
      hand.delete(land)
      battlefield.push(land)
    end
  end
end

class Game
  def initialize(deck)
    @deck = deck
    @grimoire = Zone.new(@deck.for_game(:main), :deck)
    @hand = Zone.new([], :hand)
    @graveyard = Zone.new([], :graveyard)
    @battlefield = Zone.new([], :battlefield)
    @engine = Engine.new(zones)
  end

  def begin
    @engine.run!
  end

  def zones
    {grimoire: @grimoire, hand: @hand, graveyard: @graveyard, battlefield: @battlefield}
  end
end

class Zone
  attr_accessor :cards

  def initialize(cards, name)
    @cards = cards#.map {|c| OpenStruct.new(name: c, type: c.card_type)}
    @name = name
  end
end
