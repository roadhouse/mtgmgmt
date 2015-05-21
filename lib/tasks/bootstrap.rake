namespace :bootstrap do
  desc "bootstraping app"
  task :run => [
    "db:create:all",
    "db:migrate",
    "db:seed",
    "bootstrap:load_cards",
    "bootstrap:mtgdecks"
  ]

  desc "load card data ftom mtgapi.com"
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
end
