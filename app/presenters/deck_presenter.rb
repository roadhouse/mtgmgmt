class DeckPresenter
  attr_accessor :deck

  delegate :name, :description, to: :@deck
  delegate :by_manacost, :total_by_manacost, :total_by_type, :total_by_color, to: :@stats

  def initialize(deck = nil)
    @deck = deck
    @stats = DeckStats.new(@deck.main)
  end

  def top_cards(params = {})
    Orthanc.new(params).top_cards
  end

  def top_decks
    Orthanc.new({}).top_decks
  end

  def main_ids
    @deck.main.map(&:id)
  end

  def sideboard_ids
    @deck.sideboard.map(&:id)
  end

  def main
    group_by_card_type(@deck.main)
  end

  def sideboard
    group_by_card_type(@deck.sideboard)
  end
  
  def percent_owned(user)
    user.percent_from(main_ids).truncate
  end

  def percent_owned2(user)
    user.percent_from(sideboard_ids).truncate
  end

  def card_list_from(part)
    @deck.card_decks.where(part: part).map do |entry| 
      { copies: entry.copies, card: entry.card }
    end
  end

  def group_by_card_type2(part)
    card_types = /Land|Instant|Sorcery|Enchantment|Planeswalker|Creature|Artifact/
    data = card_list_from(part).group_by do |entry| 
      entry[:card].ctype.match(card_types).to_s
    end
    
    Hash[data.sort]
  end

  private

  def group_by_card_type(pool)
    card_types = /Land|Instant|Sorcery|Enchantment|Planeswalker|Creature|Artifact/

    data = pool.group_by { |card| card.ctype.match(card_types).to_s }.sort
    
    Hash[data]
  end
end
