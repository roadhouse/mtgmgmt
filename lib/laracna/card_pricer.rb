require 'nokogiri'
require 'open-uri'

class CardPricer
  def initialize(card_name)
    @card_name = card_name
  end

  def engine
    @engine ||= Nokogiri::HTML open card_url
  end

  def card_url
    "http://ligamagic.com.br/?view=cartas/card&card=#{card_slug}"
  end

  def card_slug(card_name = @card_name)
    card_name.gsub(" ","%20").gsub("Æ", "AE")
  end

  def price
    engine.search(".preMen")
      .text.split(' ').last.gsub(',', '.').to_d
  end
end
