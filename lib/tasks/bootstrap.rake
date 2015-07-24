namespace :bootstrap do
  desc "bootstraping app"
  task :run => ["db:create"] do
    cfg = ActiveRecord::Base.configurations[Rails.env]
    exec_restore = "pg_restore --verbose --clean --no-acl --no-owner -d #{cfg["database"]} db/dump.bkp"

    system exec_restore
  end

  desc "load card data from specific set from mtgapi.com"
  task :load_set, [:set] => [:environment] do |t, args|
    MtgApi.all!(args[:set])
  end

  desc "load card data from mtgapi.com"
  task load_cards: :environment do
    %w(THS BNG JOU M15 KTK FRF DTK).each do |set|
      require './lib/laracna/crawler.rb'
      MtgApi.all!(set)
    end
  end

  desc "load decs from mtgdecks"
  task mtgdecks: :environment do
    require './lib/laracna/crawler.rb'
    Crawler.run!(:mtgdecks)
  end

  desc "load decs from scg"
  task scg: :environment do
    require './lib/laracna/crawler.rb'
    Crawler.run!(:scg)
  end

  desc "load decs from deck_lists"
  task deck_lists: :environment do
    require './lib/laracna/crawler.rb'
    Crawler.run!(:deck_lists)
  end

  desc "load decks from wizards (MTGO)"
  task mtgo: :environment do
    (8.months.ago.to_date..Date.new(2015,06,24)).to_a.reverse.each do |date|
      formated_date = date.strftime("%Y-%m-%d")
      url = "http://magic.wizards.com/en/articles/archive/mtgo-standings/standard-daily-#{formated_date}"

      begin
        deck_page = Laracna::Mtgo::DeckPage.new(url)

        p "save decks from #{url}"

        deck_page.decks.each do |deck|
          d = Deck.new(deck)
          season = d.cards.pluck(:set).compact.uniq.delete_if { |i| i == "fake"}.sort.join("-")
          d.season = season
          d.save!
        end
      rescue OpenURI::HTTPError
        p "escaping #{url}"
        next
      end
    end
  end


  desc "update all prices"
  task update_price: :environment do
    Card.all.pluck(:id).each do |id|
      Delayed::Job.enqueue CardPricerJob.new(id)
    end
  end
end
