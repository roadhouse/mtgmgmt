class MtgApi
  def initialize
    @url = "./lib/laracna/OGW.json"
  end

  def persist!
    #TODO if the card is a reprint, update the card data
    cards.flatten.map(&:save)
  end

  def cards
    CardCrawler.new(@url).ar_objects
  end
end

