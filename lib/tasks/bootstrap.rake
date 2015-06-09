namespace :bootstrap do
  desc "bootstraping app"
  task :run => ["db:create"] do
    cfg = ActiveRecord::Base.configurations[Rails.env]
    exec_restore = "pg_restore --verbose --clean --no-acl --no-owner -d #{cfg["database"]} db/dump.bkp"

    system exec_restore
  end

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
