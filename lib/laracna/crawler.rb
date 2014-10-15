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

class Roudi
  def initialize(set, page = 1)
    @set = set
    @page = page
    @url = "http://api.mtgapi.com/v2/cards?page=#{@page}&set=#{@set}"
  end

  def self.all(set)
    page_max = 15
    (1..page_max).map { |page| CardCrawler.new(set, page).cards }.find_all {|i| !i.empty?}.flatten
  end

  def cards
    file_name = "#{@set}_#{@page}.json"
    api_response = open(@url).read
    json_data = JSON.parse api_response
    File.open(file_name, "w") { |f| f.write json_data }
    p "file: #{file_name} criado"
    json_data["cards"].to_a.map do |card_data|
      attr = {
        name: card_data["name"],
        image: card_data["images"]["gatherer"],
        set: card_data["set"],
        color: nil,
        manacost: card_data["manaCost"],
        card_type: card_data["type"],
        power: card_data["power"],
        toughness: card_data["toughness"],
        rarity: card_data["rarity"],
        artist: card_data["artist"],
        number: card_data["number"],
        number_ex: nil,
        edition_id: nil,
        loyalty: card_data["loyalty"],
        text: card_data["originalText"]
      }

      Card.new attr
    end
  end
end

