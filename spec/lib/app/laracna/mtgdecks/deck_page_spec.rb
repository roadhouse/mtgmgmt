require "./spec/support/vcr"

require "./lib/app/laracna/mtgdecks/deck_page"
require "./lib/app/laracna/mtgdecks/page_url"

describe Laracna::Mtgdecks::DeckPage, :vcr do
  let(:deck_id) { 63963 }

  let(:attributes_list) do
    [:card_list, :date, :description, :name, :url]
  end

  let(:main) do
    [
     { copies: "4", name: "Rakdos Cackler" },
     { copies: "2", name: "Stormbreath Dragon" },
     { copies: "4", name: "Burning-Tree Emissary" },
     { copies: "4", name: "Firefist Striker" },
     { copies: "4", name: "Ash Zealot" },
     { copies: "2", name: "Fanatic of Mogis" },
     { copies: "4", name: "Boros Reckoner" },
     { copies: "4", name: "Chandra's Phoenix" },
     { copies: "4", name: "Magma Jet" },
     { copies: "2", name: "Boros Charm" },
     { copies: "2", name: "Lightning Strike" },
     { copies: "3", name: "Chained to the Rocks" },
     { copies: "8", name: "Mountain" },
     { copies: "4", name: "Temple of Triumph" },
     { copies: "3", name: "Mutavault" },
     { copies: "4", name: "Sacred Foundry" },
     { copies: "2", name: "Nykthos, Shrine to Nyx" }
    ]
  end

  let(:sideboard) do
    [
      { copies: "2", name: "Ratchet Bomb" },
      { copies: "2", name: "Spark Trooper" },
      { copies: "2", name: "Assemble the Legion" },
      { copies: "2", name: "Burning Earth" },
      { copies: "1", name: "Chained to the Rocks" },
      { copies: "2", name: "Boros Charm" },
      { copies: "2", name: "Skullcrack" },
      { copies: "2", name: "Warleader's Helix" }
    ]
  end
  subject { Laracna::Mtgdecks::DeckPage.new(deck_id) }

  its(:date) { should be_eql Date.parse "2014-01-11" }
  its(:description) { should be_eql "Played by Lerchenmüller, Max. Top4 in Heldenschmiede Kempten (Jan-2014)" }
  its(:name) { should be_eql "R/W Devotion" }
  its(:main) { should == main }
  its(:sideboard) { should == sideboard }

  its(:"attributes.keys.sort") { should be_eql attributes_list }
end
