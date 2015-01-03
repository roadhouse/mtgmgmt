require 'nokogiri'
require 'open-uri'

class CardPricer
  def initialize(card_name)
    @card_name = card_name
  end

  def engine
    @engine ||= Nokogiri::HTML open card_url(@card_name)
  end

  def card_url(card_name)
    card_name_slug = card_name.gsub(" ","%20")
    "http://ligamagic.com.br/?view=cartas/card&card=#{card_name_slug}"
  end

  def price
    engine.search(".preMen")
      .text.split(' ').last
      .gsub(',', '.').gsub('Æ','AE')
      .to_d
  end
end
