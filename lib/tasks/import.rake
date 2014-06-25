# require "nokogiri"

namespace :import do
  desc "import cards info from xml to db"
  task :cards => :environment do
    url = "http://magiccards.info/query?q=%2B%2Be%3Ajou%2Fen&v=spoiler&s=issue"

    cards_attributes = CardCrawler.new(url).cards_attributes

    cards_attributes.map do |card_attributes|

    # slots_maps = {
      # 0 => :name, 
      # 1 => :set,
      # 2 => :rarity,
      # 3 => :card_type,
      # 4 => :loyalty,
      # 5 => :power,
      # 6 => :thougness,
      # 7 => :manacost,
      # 8 => :converted_manacost,
      # 9 => :oracle_text,
      # 10 => :quote,
      # 11 => :illustrator,
      # 12 => :card_url
    # }

    # :name, 
    # :image, 
    # :set, 
    # :color, 
    # :manacost, 
    # :card_type, 
    # :power, 
    # :toughness, 
    # :rarity, 
    # :artist, 
    # :number, 
    # :number_ex, 
    # :edition_id, 
    # :loyalty, 
    # :text, 
    # :created_at, 
    # :updated_at, 
    end
  end
end
