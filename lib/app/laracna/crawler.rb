class Crawler
  def self.run!(page_range = 1..200, site)
    page_range.each do |page| 
      p "Page: #{page}"

      Crawler.new(page, site).run!
    end
  end

  def initialize(page, site)
    @site = site
    @index_page = index_page.new(page)
  end

  def deck_pages
    @index_page.decks_ids.map { |id| deck_page.new(id) }
  end

  def run!
    deck_pages.each do |page|
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
