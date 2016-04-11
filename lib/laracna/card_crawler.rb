require "open-uri"

class CardCrawler
  attr_reader :cards_attributes

  def initialize(set)
    @set = set
  end

  def engine
    MTG::Card.where set: @set
  end

  def ar_objects
    @cards_attributes.to_a.flatten.map { |attributes| build_card(attributes) }
  end

  def build_card(data, factory = Card)
    factory.new(data.to_hash).tap do |card|
      fullfill_object card, data

      card.toughness = data.toughness.to_i
      card.cmc = data.cmc.to_i
      card.loyalty = data.loyalty.to_i
      card.number = data.number.to_i
      card.power = data.power.to_i
    end
  end

  def fullfill_object(card, data)
    card.image = "http://magiccards.info/scans/pt/#{@set}/#{data.number}.jpg"
    card.portuguese_name = data
                           .foreign_names
                           .to_a
                           .find { |i| i.language == "Portuguese (Brazil)" }.send(:name)
    card.ctypes = data.types
    card.is_standard = true
  end
end
