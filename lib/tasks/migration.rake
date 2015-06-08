require 'benchmark'

namespace :migration do
  desc 'migrate deck list in old format to new format'
  task deck_list: :environment do
    total_decks = Deck.where(list:nil).count
    label = "#{total_decks} decks migrados"

    Benchmark.bm(label.size) do |x|
      x.report(label) do
        Deck.where(list: nil).find_each do |deck|
          main = deck.card_decks.main.map { |cd| [cd.card.name,cd.copies] }
          sideboard = deck.card_decks.sideboard.map { |cd| [cd.card.name,cd.copies] }

          deck.list = {main: Hash[main], sideboard: Hash[sideboard]}

          deck.save!
        end
      end
    end
  end
end
