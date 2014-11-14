class DeckBuilder
  Standard = OpenStruct.new(parts: %i(main sideboard))

  def initialize(format = Standard, params)
    @card_list = params.delete(:card_list)
    @deck      = Deck.new(params)
    @format    = format
  end

  def build
    @deck.tap do |deck|
      populate

      deck.save!
    end
  end

  private

  def populate
    @format.parts.each { |part| add_cards_from(part) }
  end

  def add_cards_from(part)
    @card_list.fetch(part).each do |attrs| 
      name   = attrs.fetch(:card)
      copies = attrs.fetch(:copies)

      @deck.add_card(copies, name, part)
    end

  end
end
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
class MtgApi
  def initialize(set, page)
    @set = set
    @page = page
    @url = "http://api.mtgapi.com/v2/cards?page=#{@page}&set=#{@set}"
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

