class MtgApi
  def initialize(set, page)
    @set = set
    @page = page
    @url = "http://api.mtgapi.com/v2/cards?page=#{@page}&set=#{@set.downcase}"
  end

  def self.all!(set)
    page_max = 15
    (1..page_max).map { |page| p "PAGE: #{page}"; MtgApi.new(set, page).persist! }
  end

  def persist!
    cards.flatten.map(&:save!)
  end

  def cards
    CardCrawler.new(@url).ar_objects
  end
end

