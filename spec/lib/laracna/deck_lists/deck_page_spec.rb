require "./spec/support/vcr"
require 'rspec/its'

require "./lib/laracna/deck_lists/deck_page"

describe Laracna::DeckLists::DeckPage, :vcr do
  let(:deck_id) { 23622 }

  let(:main) do
    ["4 Burning-tree Emissary", "4 Chandra's Phoenix", "4 Fanatic Of Mogis", "4 Firedrinker Satyr", "4 Firefist Striker", "4 Gore-house Chainwalker", "4 Rakdos Cackler", "4 Dragon Mantle", "4 Lightning Strike", "4 Shock", "20 Mountain"]
  end

  let(:sideboard) do
    ["3 Burning Earth", "4 Skullcrack", "2 Act Of Treason", "3 Mizzium Mortars", "3 Peak Eruption"]
  end

  let(:deck) do
    {
      :main=>[
        {:copies=>"4", :card=>"Burning-tree Emissary"}, {:copies=>"4", :card=>"Chandra's Phoenix"}, {:copies=>"4", :card=>"Fanatic Of Mogis"}, {:copies=>"4", :card=>"Firedrinker Satyr"}, {:copies=>"4", :card=>"Firefist Striker"}, {:copies=>"4", :card=>"Gore-house Chainwalker"}, {:copies=>"4", :card=>"Rakdos Cackler"}, {:copies=>"4", :card=>"Dragon Mantle"}, {:copies=>"4", :card=>"Lightning Strike"}, {:copies=>"4", :card=>"Shock"}, {:copies=>"20", :card=>"Mountain"}
      ], 
      :sideboard=>[
        {:copies=>"3", :card=>"Burning Earth"}, {:copies=>"4", :card=>"Skullcrack"}, {:copies=>"2", :card=>"Act Of Treason"}, {:copies=>"3", :card=>"Mizzium Mortars"}, {:copies=>"3", :card=>"Peak Eruption"}
      ]
    }
  end

  let(:attributes_list) do
    [:card_list, :date, :description, :name, :url, :source]
  end

  let(:config) { CrawlerConfig.new(:deck_lists) }

  subject { Laracna::DeckLists::DeckPage.new(deck_id, config) }

  its(:date) { should be_eql Date.parse("08.01.2014") }
  its(:description) { should be_eql "This deck was played at Magic Online - Standard Daily #6569298 and finished at position 5" }
  its(:name) { should be_eql "Mono Red Devotion" }
  its(:deck) { should be_eql deck }

  its(:"attributes.keys.sort") { is_expected.to be_eql attributes_list.sort }
end
