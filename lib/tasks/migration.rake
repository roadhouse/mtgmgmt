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

  desc 'update season field'
  task update_season: :environment do
    Deck.find_each do |deck|
      sets = Card.where(name: deck.list["main"].keys).pluck(:set)
      season = sets.compact.uniq.delete_if { |i| i== "fake"}.sort.join("-")

      deck.season = season
      deck.save!
    end
  end

  desc 'delete duplicate cards'
  task delete_duplicate: :environment do
    # select name, count(name) as rep from cards group by name order by rep desc 
    duplicates = ["Plains", "Swamp", "Mountain", "Island", "Forest", "Naturalize", "Divine Verdict", "Duress", "Mind Rot", "Divination", "Oppressive Rays", "Necrobite", "Dismal Backwater", "Oreskos Swiftclaw", "Typhoid Rats", "Rugged Highlands", "Swiftwater Cliffs", "Summit Prowler", "Evolving Wilds", "Wind-Scarred Crag", "Blossoming Sands", "Tranquil Cove", "Scoured Barrens", "Jungle Hollow", "Bronze Sable", "Hunt the Weak", "Satyr Wayfinder", "Cancel", "Thornwood Falls", "Battle Mastery", "Tormenting Voice", "Bloodfell Caves", "Lightning Strike", "Negate"]

    duplicates.map do |name|
      Card.where(id: Card.where(name: name).pluck(:id)[1..-1]).delete_all
    end
  end

  desc 'update deck meta data'
  task update_meta_data: :environment do
    query = Deck.all
    total_decks = query.count
    label = "#{total_decks} decks migrados"

    Benchmark.bm(label.size) do |x|
      x.report(label) do
        query.find_each { |deck| deck.update_meta_data }
      end
    end
  end
end
