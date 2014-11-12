require "./spec/support/vcr"
require 'spec_helper_active_record'
require 'json'
require 'ostruct'
require './app/models/card'

require "./lib/laracna/card_crawler.rb"

describe CardCrawler do
  let(:crawler) { VCR.use_cassette("cards") { described_class.new("http://api.mtgapi.com/v2/cards?set=KTK&page=1") } }
  # let(:crawler) { described_class.new("http://api.mtgapi.com/v2/cards?set=KTK&page=1") }
  subject { crawler }
    

  context ".build_card" do
    let(:data) { crawler.cards_attributes.first }
    subject { crawler.build_card data }

    it { is_expected.to have_attributes(name: "Abomination of Gudul") }
    it { is_expected.to have_attributes(set: "KTK") }
    it { is_expected.to have_attributes(rarity: "Common") }
    it { is_expected.to have_attributes(card_type: "Creature — Horror") }
    it { is_expected.to have_attributes(loyalty: nil) }
    it { is_expected.to have_attributes(power: "3") }
    it { is_expected.to have_attributes(toughness: "4") }
    it { is_expected.to have_attributes(manacost: "{3}{B}{G}{U}") }
    it { is_expected.to have_attributes(text: "Flying\nWhenever Abomination of Gudul deals combat damage to a player, you may draw a card. If you do, discard a card.\nMorph {2}{B}{G}{U} (You may cast this card face down as a 2/2 creature for {3}. Turn it face up any time for its morph cost.)") }
    it { is_expected.to have_attributes(artist: "Erica Yang") } 
    it { is_expected.to have_attributes(number: "159") } 
  end
end
