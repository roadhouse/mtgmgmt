class Crawler
  def self.run!(site, page_range = 1..400, options = {})
    page_range.each do |page|
      p "Page: #{page}"

      Crawler.new(page, site, options).run!
    end
  end

  def initialize(page, site, options = {})
    @site = site
    @index_page = index_page.new page
    @exceptions = options.fetch(:except) { [] }
  end

  def items
    @index_page.decks_ids.map { |id| deck_page.new(id) unless @exceptions.include? id }.compact
  end

  def run!
    items.each do |page|
      p "Deck url = #{page.url}"

      begin
        DeckBuilder.new(page.attributes).build
      rescue Laracna::InvalidPageError
        p "escaping #{page.url}"
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
