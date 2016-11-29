require './lib/laracna/card_crawler'

namespace :cards do
  desc "load card data using mtg-sdk"
  task :load, [:set] => :environment do |_, args|
    raise ArgumentError, "Code set required (like 'soi' or 'kld')" unless args[:set].present?

    p CardCrawler.new(args[:set]).persist!
  end
end
