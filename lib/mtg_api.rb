class MtgApi
  def initialize(set=nil)
    @set = set
    @url = "./lib/laracna/OGW.pt.json"
  end

  def persist!
    #TODO if the card is a reprint, update the card data
    cards.flatten.map(&:save)
  end

  def cards
    CardCrawler.new(@url).ar_objects
  end
end

