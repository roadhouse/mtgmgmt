require 'nokogiri'
require 'open-uri'

class CardCrawler
  def initialize(url)
    document = Nokogiri::HTML(open(url))
    card_nodes = document.search("table")[3].search("td")

    @cards_attributes = card_collection(card_nodes)
  end

  def card_collection(card_nodes)
    card_nodes.map { |card_node| CardData.new(card_node) }
  end

  def run
    @card_attributes.each do |card_attribute|
      Card.create!(card_attribute)
    end
  end
end

class CardData
  def initialize(page)
    document = Nokogiri::HTML(page)

    @card_nodes = document.search("table")[3].search("td")
    @card_data = card_data(@card_nodes)
  end

  def card_collection
    @card_nodes.map { |card_node| CardData.new(card_node) }
  end

  def name
    @card_data[0]
  end

  def set
    @card_data[1].split(",").map(&:strip)[0]
  end
  
  def rarity
    @card_data[1].split(",").map(&:strip)[1]
  end

  def card_type
    @card_data[2].split(",")[1]
  end

  def manacost
    @card_data[3].split(" ").first
  end
  
  def converted_manacost
    @card_data[3].split(" ").last.scan(/\d/)
  end

  def oracle_text
    @card_data[4]
  end

  def illustrator
    @card_data[5]
  end

  def card_url
    @card_data[6]
  end
  
  def attributes
    {
      name: name,
      set: set,
      rarity: rarity,
      card_type: card_type,
      manacost: manacost,
      converted_manacost: converted_manacost,
      oracle_text: oracle_text,
      illustrator: illustrator,
      card_url: card_url,
    }
  end

  private

  def card_data(node)
    card_url = node.search("a").attribute("href").text

    node.text.split("/n").delete_if(&:empty?).map(&:strip).push(card_url)
  end
end
