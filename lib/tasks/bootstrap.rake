namespace :bootstrap do
  desc "bootstraping app"
  task :run => [
    "db:create:all",
    "db:migrate",
    "db:seed",
  ]

  desc "load card data ftom mtgapi.com"
  task load_cards: :environment do
    %w(THS BNG JOU M15 KTK).each do |set|
      require './lib/laracna/crawler.rb'
      MtgApi.all!(set)
    end
  end

  desc "load decs from mtgdecks"
  task mtgdecks: :environment do
    require './lib/laracna/crawler.rb'
    Crawler.run!(:mtgdecks)
  end
end
