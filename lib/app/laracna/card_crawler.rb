require 'nokogiri'
require 'open-uri'

class CardCrawler
  attr_reader :cards_attributes

  def initialize(url)
    document   = Nokogiri::HTML(open(url))
    card_nodes = document.search("table")[3].search("td[valign='top']")

    @cards_attributes = card_collection(card_nodes)
  end

  def card_collection(card_nodes)
    card_nodes.map { |card_node| new_card_data raw_attributes(card_node) }
  end

  def new_card_data(data, factory = OpenStruct)
    slots_maps = {
      0 => :name, 
      1 => :set,
      2 => :rarity,
      3 => :card_type,
      4 => :loyalty,
      5 => :power,
      6 => :thougness,
      7 => :manacost,
      8 => :converted_manacost,
      9 => :oracle_text,
      10 => :quote,
      11 => :illustrator,
      13 => :card_url,
      14 => :image_url,
      15 => :number
    }

    # require 'pry'; binding.pry
    data[1] = data[1].split(",").map(&:strip)
    data[3] = data[3].split(" ")#.tap { |i|  i[1] = i[1].split(" ")[1].gsub(/\(|\)/,"")}


    t = data[2].split("—")
    body_or_loyalty = t[1].to_s.split.delete_if { |field| field =~ /\(Loyalty:/ }
    head = t[0]

    unless body_or_loyalty.empty?
      head = [t[0], body_or_loyalty[0..-2]]
    end
    
    require 'pry'; binding.pry
    data[2] = [head, body_or_loyalty]
      # data[3] = [ t[0,3].join(" "), t[-1].gsub(/\)|\,/,""), Array.new(2) {""} ]

    # if data[3] =~ /Instant|Enchantment —|Enchantment,|Artifact|Sorcery/
      # data[3] = [ data[3].gsub(",",""), Array.new(4) { "" } ]
    # end

    # if data[3] =~ /Creature/
      # temp = data[3].split(" ")
      # power = temp.delete(temp[-1])
      # if data.size == 10
        # data[3] = [ temp.join(" "), "", "", power.gsub(/,/,"").split("/") ]
      # else
        # data[3] = [ temp.join(" "), "", power.gsub(/,/,"").split("/") ]
      # end

      # data[4] = data[4].split(" ").tap {|d| d[1] = d[1].gsub(/\(|\)/,"")}
    # end

    # if data[3] =~ /Land/
      # if data.size == 7
        # data[3] = [ data[3].gsub(",",""), Array.new(6) { "" } ]
      # end
      # if data.size == 9
        # data[3] = [ data[3].gsub(",",""), Array.new(5) { "" } ]
      # end
      # if data.size == 8
        # data[3] = [ data[3].gsub(",",""), Array.new(5) { "" } ]
      # end
    # end

    # if data[3] =~ /Planeswalker/
      # t = data[3].split(" ")
      # data[3] = [ t[0,3].join(" "), t[-1].gsub(/\)|\,/,""), Array.new(2) {""} ]

      # data[4] = data[4].split(" ").tap {|d| d[1] = d[1].gsub(/\(|\)/,"") }

      # data[5] = [ data[5], "" ]
    # end

    factory.new Hash[ slots_maps.values.zip(data.flatten) ]
  end

  def raw_attributes(node)
    unless node.search("a").empty?
      data = node.text.split("\n").map(&:strip).delete_if(&:empty?)
      data[4] = node.search("p.ctext").children.children.to_s.gsub(/<br><br>/,"\n")
      card_url = node.search("a").attribute("href").text
      data.push(card_url)
      # number   = card_url.match(/\d/)[0]
      # set_code = card_url.split("/")[1]
      # lang     = card_url.split("/")[2]
      # data = data.push("/scans/#{lang}/#{set_code}/#{number}.jpg")
      # data = data.push(number)
    end

  end
end

class CardBuilder
  def initialize(card_attributes, ar_model)
    @card_attributes = cards_attributes
    @ar_model        = ar_model
  end

  def build
    @ar_model.new ar_attributes(@card_attributes)
  end

  def ar_attributes(card_attributes)
    {
      name: cards_attributes.name,
      image_url: cards_attributes.image_url, 
      set: cards_attributes.set, 
      manacost: cards_attributes.manacost, 
      card_type: cards_attributes.card_type, 
      power: cards_attributes.power, 
      toughness: cards_attributes.thougness, 
      rarity: cards_attributes.rarity, 
      artist: cards_attributes.artist, 
      number: cards_attributes.number, 
      loyalty: cards_attributes.loyalty, 
      oracle_text: cards_attributes.oracle_text, 
      quote: cards_attributes.quote, 
    }
  end
end
