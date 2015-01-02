require 'nokogiri'
require 'open-uri'

class CardPricer
  def initialize(card_name)
    @card_name = card_name
  end

  def card_url(card_name)
    card_name_slug = card_name.gsub(" ","%20")
    "http://ligamagic.com.br/?view=cartas/card&card=#{card_name_slug}"
  end

  def price
    @document ||= Nokogiri::HTML open card_url(@card_name)

    @document.search(".preMen").text.split(' ').last.to_f
  end
end
