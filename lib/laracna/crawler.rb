class Crawler
  def self.run!(site, page_range = 1..200, options = {})
    page_range.each do |page| 
      p "Page: #{page}"

      Crawler.new(page, site, options).run!
    end
  end

  def initialize(page, site, options = {})
    @site = site
    @index_page = index_page.new(page)
    @exceptions = Array[ options.fetch(:except) { nil } ].flatten
  end

  def items
    @index_page.decks_ids.map { |id| deck_page.new(id) unless @exceptions.include? id }.compact
  end

  def run!
    items.each do |page|
      p "Deck url = #{page.url}"

      DeckBuilder.new(page.attributes).build
    end
  end
  
  private

  def index_page
    "Laracna::#{@site.to_s.camelize}::IndexPage".constantize
  end

  def deck_page
    "Laracna::#{@site.to_s.camelize}::DeckPage".constantize
  end
end

require 'open-uri'
class Roudi
  def initialize(set, page)
    @set = set
    @page = page
    @url = "http://api.mtgapi.com/v2/cards?page=#{@page}&set=#{@set}"
  end

  def self.all(set)
    page_max = 15
    (1..page_max).map { |page| p "PAGE: #{page}"; Roudi.new(set, page).persist! }
  end

  def persist!
    cards.flatten.map(&:save!)
  end

  def cards
    CardCrawler.new(@url).ar_objects
  end
end

