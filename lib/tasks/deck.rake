namespace :deck do
  desc "load decks from mtgdecks"
  task mtgdecks: :environment do
    Crawler.run!(:mtgdecks)
  end

  desc "load decks from scg"
  task scg: :environment do
    Crawler.run!(:scg)
  end

  desc "load decks from wizards (MTGO)"
  task mtgo: :environment do
    urls = %w(
        http://magic.wizards.com/en/articles/archive/mtgo-standings/standard-ptq-
        http://magic.wizards.com/en/articles/archive/mtgo-standings/competitive-standard-constructed-league-
    )
    urls.each do |url|
      (4.months.ago.to_date..DateTime.now.to_date).to_a.reverse.each do |date|
        formated_date = date.strftime("%Y-%m-%d")
        final_url = url + formated_date

        begin
          deck_page = Laracna::Mtgo::DeckPage.new(final_url)

          p "save decks from #{final_url}"

          deck_page.decks.each do |deck|
            d = Deck.new(deck)
            d.save!
            d.update_meta_data
          end
        # rescue
          # p "escaping #{final_url}"
          # next
        end
      end
    end
  end
end
