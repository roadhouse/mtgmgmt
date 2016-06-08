namespace :deck do
  desc "load decks from mtgdecks"
  task mtgdecks: :environment do
    require './lib/laracna/laracna'
    Crawler.run!(:mtgdecks)
  end

  desc "load decks from scg"
  task scg: :environment do
    require './lib/laracna/crawler.rb'
    Crawler.run!(:scg)
  end

  desc "load decks from wizards (MTGO)"
  task mtgo: :environment do
    (4.months.ago.to_date..DateTime.now.to_date).to_a.reverse.each do |date|
      formated_date = date.strftime("%Y-%m-%d")
      # http://magic.wizards.com/en/articles/archive/mtgo-standings/standard-ptq-2016-06-06
      url = "http://magic.wizards.com/en/articles/archive/mtgo-standings/competitive-standard-constructed-league-#{formated_date}"

      begin
        deck_page = Laracna::Mtgo::DeckPage.new(url)

        p "save decks from #{url}"

        deck_page.decks.each do |deck|
          d = Deck.new(deck)
          d.save!
          d.update_meta_data
        end
      rescue OpenURI::HTTPError
        p "escaping #{url}"
        next
      end
    end
  end
end
