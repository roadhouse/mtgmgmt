namespace :cards do
  desc "load card data using mtg-sdk"
  task :load, [:set] => :environment do |_, args|
    raise ArgumentError, "Code set required (like 'soi' or 'kld')" unless args[:set].present?

    report = CardCrawler.new(args[:set]).persist!

    p "Importação do set #{@set} terminada: #{report}"
  end
end
