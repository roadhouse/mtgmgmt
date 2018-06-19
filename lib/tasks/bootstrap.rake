namespace :bootstrap do
  desc "bootstraping app"
  task :run do
    cfg = ActiveRecord::Base.configurations[Rails.env]
    exec_restore = "pg_restore -h db -Udocker --verbose --clean --no-acl --no-owner -d #{cfg["database"]} db/dump.bkp"

    system exec_restore
  end

  desc "load card data using mtg-sdk"
  task load_cards: :environment do
    require './lib/laracna/card_crawler'
    p CardCrawler.new("emn").persist!
  end
end
