require "./spec/support/vcr"
require 'rspec/its'

require "./lib/laracna/mtgdecks/deck_page"
require "./lib/laracna/crawler_config"

describe Laracna::Mtgdecks::DeckPage, :vcr do
  let(:deck_id) { 63963 }

  let(:attributes_list) do
    [:card_list, :description, :name, :url, :source]
  end

  let(:main) do
    [
     { copies: "4", card: "Rakdos Cackler" },
     { copies: "2", card: "Stormbreath Dragon" },
     { copies: "4", card: "Burning-Tree Emissary" },
     { copies: "4", card: "Firefist Striker" },
     { copies: "4", card: "Ash Zealot" },
     { copies: "2", card: "Fanatic of Mogis" },
     { copies: "4", card: "Boros Reckoner" },
     { copies: "4", card: "Chandra's Phoenix" },
     { copies: "4", card: "Magma Jet" },
     { copies: "2", card: "Boros Charm" },
     { copies: "2", card: "Lightning Strike" },
     { copies: "3", card: "Chained to the Rocks" },
     { copies: "8", card: "Mountain" },
     { copies: "3", card: "Mutavault" },
     { copies: "4", card: "Temple of Triumph" },
     { copies: "4", card: "Sacred Foundry" },
     { copies: "2", card: "Nykthos, Shrine to Nyx" }
    ]
  end

  let(:sideboard) do
    [
      { copies: "2", card: "Assemble the Legion" },
      { copies: "2", card: "Ratchet Bomb" },
      { copies: "2", card: "Skullcrack" },
      { copies: "2", card: "Spark Trooper" },
      { copies: "2", card: "Warleader's Helix" },
      { copies: "2", card: "Burning Earth" },
      { copies: "1", card: "Chained to the Rocks" },
      { copies: "2", card: "Boros Charm" },
    ]
  end

  let(:config) { CrawlerConfig.new(:mtgdecks) }
  subject { Laracna::Mtgdecks::DeckPage.new(deck_id, config) }

  its(:description) { is_expected.to eql "R/W Devotion.Lerchenmüller, Max.Top4Heldenschmiede Kempten[13 Players] 11-Jan-2014" }
  its(:name) { is_expected.to be_eql "R/W Devotion" }
  its(:"attributes.keys.sort") { is_expected.to be_eql attributes_list.sort }
end
