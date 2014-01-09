require "./spec/support/vcr"

require "./lib/app/laracna/deck_lists/deck_page"
require "./lib/app/laracna/deck_lists/page_url"

describe Laracna::DeckLists::DeckPage, :vcr do
  let(:deck_id) { 23622 }

  let(:main) do
    ["4 Burning-tree Emissary", "4 Chandra's Phoenix", "4 Fanatic Of Mogis", "4 Firedrinker Satyr", "4 Firefist Striker", "4 Gore-house Chainwalker", "4 Rakdos Cackler", "4 Dragon Mantle", "4 Lightning Strike", "4 Shock", "20 Mountain"]
  end

  let(:sideboard) do
    ["3 Burning Earth", "4 Skullcrack", "2 Act Of Treason", "3 Mizzium Mortars", "3 Peak Eruption"]
  end

  let(:deck) do
    "4 Burning-tree Emissary\r\n4 Chandra's Phoenix\r\n4 Fanatic Of Mogis\r\n4 Firedrinker Satyr\r\n4 Firefist Striker\r\n4 Gore-house Chainwalker\r\n4 Rakdos Cackler\r\n4 Dragon Mantle\r\n4 Lightning Strike\r\n4 Shock\r\n20 Mountain\r\n\r\n3 Burning Earth\r\n4 Skullcrack\r\n2 Act Of Treason\r\n3 Mizzium Mortars\r\n3 Peak Eruption"
  end

  let(:attributes_list) do
    [:card_list, :date, :description, :name, :url]
  end

  subject { Laracna::DeckLists::DeckPage.new(deck_id) }

  its(:date) { should be_eql Date.parse("08.01.2014") }
  its(:description) { should be_eql "This deck was played at Magic Online - Standard Daily #6569298 and finished at position 5" }
  its(:name) { should be_eql "Mono Red Devotion" }
  its(:deck) { should be_eql deck }

  its(:"attributes.keys.sort") { should be_eql attributes_list }
end
