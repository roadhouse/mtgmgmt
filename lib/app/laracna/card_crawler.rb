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

  def run
    @cards_attributes.each do |card_attribute|
      p card_attribute.attributes
    end
  end

  def new_card_data(data)
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
      12 => :card_url
    }


    if data[3] =~ /Instant|Enchantment —|Enchantment,|Artifact|Sorcery/
      if data.size == 9
        data[3] = [ data[3].gsub(",",""), Array.new(4) { "" } ]
      else
        data[3] = [ data[3].gsub(",",""), Array.new(5) { "" } ]
      end
    end
    if data[3] =~ /Creature/
      temp = data[3].split(" ")
      power = temp.delete(temp[-1])
      if data.size == 8
        data[3] = [ temp.join(" "), "", "", power.gsub(/,/,"").split("/") ]
      else
        data[3] = [ temp.join(" "), "", power.gsub(/,/,"").split("/") ]
      end

      data[4] = data[4].split(" ").tap {|d| d[1] = d[1].gsub(/\(|\)/,"")}
    end

    if data[3] =~ /Land/
      if data.size == 7
        data[3] = [ data[3].gsub(",",""), Array.new(6) { "" } ]
      end
      if data.size == 9
        data[3] = [ data[3].gsub(",",""), Array.new(5) { "" } ]
      end
      if data.size == 8
        data[3] = [ data[3].gsub(",",""), Array.new(5) { "" } ]
      end
    end

    if data[3] =~ /Planeswalker/
      t = data[3].split(" ")
      data[3] = [ t[0,3].join(" "), t[-1].gsub(/\)|\,/,""), Array.new(2) {""} ]

      data[4] = data[4].split(" ").tap {|d| d[1] = d[1].gsub(/\(|\)/,"") }

      data[5] = [ data[5], "" ]
    end

    OpenStruct.new Hash[ slots_maps.values.zip(data.flatten) ]
  end

  def raw_attributes(node)
    unless node.search("a").empty?
      card_url = node.search("a").attribute("href").text

      data = node.text.split("\n").push(card_url)

      data.delete_if(&:empty?).tap { |d| d[1] = d[1].split(",") }.flatten.map(&:strip).delete_if(&:empty?).map(&:strip).delete_if(&:empty?)
      #.tap {|d| d[4] = d[4]}.tap {|d| d[4]=d[4].split(" ")}.flatten.tap {|d| d[5]=d[5].gsub(/(\d)/).first}
    end

  end
end
