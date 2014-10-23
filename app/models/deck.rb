class Deck < ActiveRecord::Base
  has_many :card_decks
  has_many :cards, through: :card_decks

  validates_uniqueness_of :url

  def add_card(copies, name, part)
    begin
      card_decks.build(card: Card.find_by_name!(name), copies: copies, part: part)
    rescue ActiveRecord::RecordNotFound
      raise name
    end
  end

  def main
    group_by_card_type(:main)
  end

  def sideboard
    group_by_card_type(:sideboard)
  end


  def card_list_from(part)
    card_decks.where(part: part).map do |entry| 
      { copies: entry.copies, card: entry.card }
    end
  end

  private

  def group_by_card_type(part)
    data = card_list_from(part).group_by do |deck_entry| 
      deck_entry[:card].card_type.match(/Land|Instant|Sorcery|Enchantment|Planeswalker|Creature|Artifact/).to_s
    end
    
    Hash[data.sort]
  end
end
