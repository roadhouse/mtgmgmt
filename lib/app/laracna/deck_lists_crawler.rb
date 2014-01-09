class DeckListsCrawler
  def self.run!(page_range = 1..200)
    page_range.each do |page| 
      p "Page: #{page}"

      DeckListsCrawler.new(page).run!
    end
  end

  def initialize(page)
    @page = page
  end

  def deck_pages
    DecksListPage.new(@page).decks_ids
      .map { |id| DeckPage.new(id) }
  end

  def run!
    deck_pages.each do |page|
      p "Deck url = #{page.url}"

      DeckBuilder.new(page.attributes).build
    end
  end
end
