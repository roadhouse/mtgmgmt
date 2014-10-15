require 'open-uri'

class CardCrawler
  attr_reader :cards_attributes

  def initialize(set)
    document = JSON.parse open("http://api.mtgapi.com/v2/cards?set=#{set}").read
    @cards_attributes = document['cards']
  end

  def ar_objects
    @cards_attributes.map { |attributes| build_card(attributes) }
  end

  def build_card(data, factory = OpenStruct)
    factory.new({
      name: data['name'], 
      set: data['set'],
      rarity: data['rarity'],
      card_type: data['type'],
      loyalty: data['loyalty'],
      power: data['power'],
      toughness: data['toughness'],
      manacost: data['manaCost'],
      text: data['originalText'],
      artist: data['artist'],
      number: data["number"] 
    })
  end
end
