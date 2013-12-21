# require "nokogiri"

namespace :import do
  desc "import cards info from xml to db"
  task :cards => :environment do
    card_list = Nokogiri::XML(File.open("#{Rails.root}/lib/assets/cards.xml")).search("card")
    #c = XmlImport.new("path", CockatriceXmlParser).process!
    
    c = card_list.map do |card|
      {
        :name      => card.search("name").text,
        :image     => card.search("set").attribute("picURL").text,
        :set       => card.search("set").text,
        :color     => card.search("color").text,
        :manacost  => card.search("manacost").text,
        :card_type => card.search("type").text,
        :text      => card.search("text").text,
        :loyalty   => card.search("loyalty").text,
        :power     => card.search("pt").text.split("/").first,
        :toughness => card.search("pt").text.split("/").first
      } 
    end

    c.each { |card_attributes| Card.create!(card_attributes); p "#{card_attributes[:name]}\n" }
  end
end

# class XmlImport
  # def initialize(path, parser)
    # @path = path
    # @parser = parser
  # end

  # def process!
    # repository.map do |card|
      # card_data = @parser.new(card)

      # {
        # :name      => card_data.name,
        # :image     => card_data.image,
        # :set       => card_data.set,
        # :color     => card_data.color,
        # :manacost  => card_data.manacost,
        # :card_type => card_data.card_type,
        # :text      => card_data.text,
        # :loyalty   => card_data.loyalty,
        # :power     => card_data.power,
        # :toughness => card_data.toughness
      # } 
    # end
  # end

  # def repository
    # Nokogiri::XML(File.open(@path)).search("card")
  # end
# end

# class CockatriceXmlParser
  # def initialize(node)
    # @card_data = node
  # end

  # def name
    # node.search("name").text 
  # end
  
  # def image
    # node.search("set").attribute("picURL").text 
  # end

  # def set       
    # card.search("set").text
  # end

  # def color     
    # card.search("color").text
  # end

  # def manacost  
    # card.search("manacost").text
  # end

  # def card_type 
    # card.search("type").text
  # end

  # def text      
    # card.search("text").text
  # end
  
  # def loyalty   
    # card.search("loyalty").text
  # end

  # def power      
    # card.search("pt").split("/").first
  # end
  
  # def toughness      
    # card.search("pt").split("/").last
  # end
# end
