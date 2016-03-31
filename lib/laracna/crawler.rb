class Crawler
  def self.run!(site, page_range = 1..400, options = {})
    page_range.each { |page| Crawler.new(page, site, options).run! }
  end

  def initialize(page, site, options = {})
    @page = page
    @site = site
    @index_page = index_page.new page
    @exceptions = options.fetch(:except) { [] }
  end

  def items
    @index_page.urls
      .map { |url| deck_page.new(url) unless @exceptions.include? url }
      .compact
  end

  def run!
    p "Downloading decks from page #{@page} in #{@site}"
    items.each do |page|
      begin
        DeckBuilder.new(page.attributes).build
      rescue Laracna::InvalidPageError => e
        p "Invalid Deck List: #{e.message}"
        next
      end
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
