require "./spec/support/vcr"
require 'rspec/its'

require "./lib/laracna/scg/deck_page"
require "./lib/laracna/scg/page_url"

describe Laracna::Scg::DeckPage, :vcr do
  let(:deck_id) { 63963 }

  let(:attributes_list) do
    [:card_list, :description, :name, :url, :source]
  end

  let(:main) do
    [
      {:copies=>"4", :card=>"Experiment One"},
      {:copies=>"1", :card=>"Figure of Destiny"},
      {:copies=>"2", :card=>"Flinthoof Boar"},
      {:copies=>"4", :card=>"Ghor-Clan Rampager"},
      {:copies=>"4", :card=>"Kird Ape"},
      {:copies=>"4", :card=>"Loam Lion"},
      {:copies=>"4", :card=>"Tarmogoyf"},
      {:copies=>"4", :card=>"Wild Nacatl"},
      {:copies=>"1", :card=>"Forest"},
      {:copies=>"1", :card=>"Mountain"},
      {:copies=>"4", :card=>"Arid Mesa"},
      {:copies=>"2", :card=>"Misty Rainforest"},
      {:copies=>"1", :card=>"Sacred Foundry"},
      {:copies=>"2", :card=>"Scalding Tarn"},
      {:copies=>"3", :card=>"Stomping Ground"},
      {:copies=>"2", :card=>"Temple Garden"},
      {:copies=>"4", :card=>"Verdant Catacombs"},
      {:copies=>"1", :card=>"Chained to the Rocks"},
      {:copies=>"4", :card=>"Lightning Bolt"},
      {:copies=>"1", :card=>"Lightning Helix"},
      {:copies=>"3", :card=>"Mutagenic Growth"},
      {:copies=>"4", :card=>"Path to Exile"}
    ]
  end

  let(:sideboard) do
    [
      {:copies=>"1", :card=>"Grafdigger's Cage"},
      {:copies=>"2", :card=>"Spellskite"},
      {:copies=>"2", :card=>"Ranger of Eos"},
      {:copies=>"2", :card=>"Chained to the Rocks"},
      {:copies=>"2", :card=>"Stony Silence"},
      {:copies=>"2", :card=>"Combust"},
      {:copies=>"1", :card=>"Destructive Revelry"},
      {:copies=>"3", :card=>"Pyroclasm"}
    ]
  end

  subject { Laracna::Scg::DeckPage.new(deck_id) }

  its(:description) { is_expected.to eql "245th Place at Pro Tour on 2/23/2014" }
  its(:name) { is_expected.to be_eql "Zoo" }
  its(:main) { is_expected.to eql main }
  its(:sideboard) { is_expected.to eql sideboard }

  its(:"attributes.keys.sort") { should be_eql attributes_list.sort }
end
