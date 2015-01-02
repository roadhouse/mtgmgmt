require 'open-uri'

class CardCrawler
  attr_reader :cards_attributes

  def initialize(url)
    document = JSON.parse open(url).read
    @cards_attributes = document['cards']
  end

  def ar_objects
    @cards_attributes.to_a.flatten.map { |attributes| build_card(attributes) }
  end

  def build_card(data, factory = Card)
    factory.new(
      artist: data['artist'],
      border: data["border"],
      ctype: data['type'],
      flavor: data["flavor"],
      image: data["images"]["mtgimage"],
      layout: data["layout"],
      mana_cost: data['manaCost'],
      name: data['name'], 
      original_text: data['originalText'],
      original_type: data["originalType"],
      portuguese_name: data["foreignNames"].find {|i| i["language"] == "Portuguese (Brazil)"}.to_h.fetch("name"){data["name"]},
      rarity: data['rarity'],
      set: data['set'],
      supertypes: data["supertypes"],
      toughness: data['toughness'],

      cmc: data["cmc"].to_i,
      loyalty: data["loyalty"].to_i,
      multiverse_id: data["multiverseid"],
      number: data["number"].to_i,
      power: data["power"].to_i,
      toughness: data["toughness"].to_i,

      colors: data["colors"],
      ctypes: data["types"],
      names: data["names"],
      printings: data["printings"],
      subtypes: data["subtypes"],

      # foreign_names: data["foreignNames"],
      # legalities: data["legalities"],
      # rulings: data["rulings"]
    )
  end
end
