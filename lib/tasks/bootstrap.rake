namespace :bootstrap do
  desc "bootstraping app"
  task :run => ["db:create"] do
    cfg = ActiveRecord::Base.configurations[Rails.env]
    exec_restore = "pg_restore --verbose --clean --no-acl --no-owner -d #{cfg["database"]} db/dump.bkp"

    system exec_restore
  end

  desc "load card data from specific set from mtgapi.com"
  task :load_set, [:set] => [:environment] do |t, args|
    MtgApi.new
  end

  desc "load card data from mtgapi.com"
  task load_cards: :environment do
    %w(BFZ).each do |set|
      require './lib/laracna/crawler.rb'
      MtgApi.all!(set)
    end
  end
end
