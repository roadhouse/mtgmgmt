require "./spec/support/vcr"

require "./lib/app/laracna/mtgdecks/deck_page"
require "./lib/app/laracna/mtgdecks/page_url"

describe Laracna::Mtgdecks::DeckPage, :vcr do
  let(:deck_id) { 63963 }

  let(:deck) do
    "4 Rakdos Cackler \n\n2 Stormbreath Dragon \n\n4 Burning-Tree Emissary \n\n4 Firefist Striker \n\n4 Ash Zealot \n\n2 Fanatic of Mogis \n\n4 Boros Reckoner \n\n4 Chandra's Phoenix\r\n4 Rakdos Cackler\r\n2 Stormbreath Dragon\r\n4 Burning-Tree Emissary\r\n4 Firefist Striker\r\n4 Ash Zealot\r\n2 Fanatic of Mogis\r\n4 Boros Reckoner\r\n4 Chandra's Phoenix\r\n4 Magma Jet \n\n2 Boros Charm \n\n2 Lightning Strike\r\n4 Magma Jet\r\n2 Boros Charm\r\n2 Lightning Strike\r\n3 Chained to the Rocks\r\n3 Chained to the Rocks\r\n8 Mountain \n\n4 Temple of Triumph \n\n3 Mutavault \n\n4 Sacred Foundry \n\n2 Nykthos, Shrine to Nyx\r\n8 Mountain\r\n4 Temple of Triumph\r\n3 Mutavault\r\n4 Sacred Foundry\r\n2 Nykthos, Shrine to Nyx\r\n\r\n2 Ratchet Bomb\r\n2 Spark Trooper\r\n2 Assemble the Legion\r\n2 Burning Earth\r\n1 Chained to the Rocks\r\n2 Boros Charm\r\n2 Skullcrack\r\n2 Warleader's Helix"
  end

  let(:attributes_list) do
    [:card_list, :date, :description, :name, :url]
  end

  subject { Laracna::Mtgdecks::DeckPage.new(deck_id) }

  its(:date) { should be_eql Date.parse "2014-01-11" }
  its(:description) { should be_eql "Played by Lerchenmüller, Max. Top4 in Heldenschmiede Kempten (Jan-2014)" }
  its(:name) { should be_eql "R/W Devotion" }
  its(:deck) { should == deck }

  its(:"attributes.keys.sort") { should be_eql attributes_list }
end
