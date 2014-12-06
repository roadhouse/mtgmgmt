class DeckPresenter < BasePresenter
  attr_accessor :deck

  delegate :name, :description, to: :@deck

  delegate :by_manacost, :total_by_manacost, :total_by_type, :total_by_color, to: :@stats

  def initialize(deck = nil)
    @deck      = deck
    @main      = deck.main
    @sideboard = deck.sideboard

    @stats = DeckStats.new(deck.main)
  end

  def archeptype_deck
    DeckPresenter.new @deck.archeptype_deck
  end

  def main
    group_by_card_type(@main)
  end

  def sideboard
    group_by_card_type(@sideboard)
  end
  
  def percent_owned(user, part)
    user.percent_from(card_pool(part).map {|i| i[:card]}).truncate
  end

  def group_by_card_type(part)
    card_types = /Land|Instant|Sorcery|Enchantment|Planeswalker|Creature|Artifact/

    data = card_pool(part).group_by { |card| card[:card].ctype.match(card_types).to_s }.sort
    
    Hash[data]
  end
  
  def colors_list
    @deck.cards.map(&:colors).flatten.compact.uniq.map(&:downcase).sort.map do |color|
      # "<i class=\"icon-stop #{color}\"></i>"
      {
          "red" => "<i class=\"icon-fire red\"></i>",
          "blue" =>"<i class=\"icon-tint blue\"></i>",
          "black" =>"<i class=\"icon-skull black\"></i>",
          "green" =>"<i class=\"icon-leaf green\"></i>",
          "white" =>"<i class=\"icon-sun-day white\"></i>"
      }.fetch(color)
    end
  end
 
  private

  def card_pool(part)
    @deck.card_decks.where(part: part).map do |entry| 
      { copies: entry.copies, card: entry.card }
    end
  end
end
