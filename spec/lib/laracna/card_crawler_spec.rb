require "./spec/support/vcr"
require "spec_helper_active_record"
require "json"
require "ostruct"
require "./app/models/card"

require "./lib/laracna/card_crawler.rb"

describe CardCrawler do
  let(:crawler) { VCR.use_cassette("cards") { described_class.new("http://api.mtgapi.com/v2/cards?set=KTK&page=1") } }
  subject { crawler }


  context ".build_card" do
    let(:data) { crawler.cards_attributes.first }
    subject { crawler.build_card data }

    it { is_expected.to have_attributes(name: "Abomination of Gudul") }
    it { is_expected.to have_attributes(set: "KTK") }
    it { is_expected.to have_attributes(rarity: "Common") }
    it { is_expected.to have_attributes(ctype: "Creature — Horror") }
    it { is_expected.to have_attributes(loyalty: 0) }
    it { is_expected.to have_attributes(power: 3) }
    it { is_expected.to have_attributes(toughness: 4) }
    it { is_expected.to have_attributes(mana_cost: "{3}{B}{G}{U}") }
    it { is_expected.to have_attributes(original_text: "Flying\nWhenever Abomination of Gudul deals combat damage to a player, you may draw a card. If you do, discard a card.\nMorph {2}{B}{G}{U} (You may cast this card face down as a 2/2 creature for {3}. Turn it face up any time for its morph cost.)") }
    it { is_expected.to have_attributes(artist: "Erica Yang") }
    it { is_expected.to have_attributes(number: 159) }
  end
end

describe CardCrawlerPreview do
  require "nokogiri"
  let(:crawler) { VCR.use_cassette("mythicspoiler") { described_class.new("http://mythicspoiler.com/ogw/index.html")} }

  context '.card_list_urls' do
    subject { crawler.card_list_urls }

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a String }
    it { is_expected.to all start_with 'cards/' }
    it { is_expected.to all end_with '.html' }
  end

  context '.cards_attributes' do
    let(:card_url) { 'http://mythicspoiler.com/ogw/cards/generaltazri.html' }

    subject { VCR.use_cassette("card_page") { crawler.card_attributes card_url } }

    it { is_expected.to be_a Hash }
    it { is_expected.to include :name }
    it { is_expected.to include :mana_cost }
    it { is_expected.to include :ctype }
    it { is_expected.to include :original_text }
    it { is_expected.to include :artist }
    it { is_expected.to include :power }

    its([:name]) { is_expected.to be_eql "General Tazri" }
    its([:mana_cost]) { is_expected.to be_eql "4W" }
    its([:ctype]) { is_expected.to be_eql "Legendary Creature - Human Ally" }
    its([:original_text]) { is_expected.to be_eql "When General Tazri enters the battlefield, you may search your library for an Ally creature card, reveal it, put it into your hand, then shuffle your library.\nWUBRG: Ally creatures you control get +X/+X until end of turn, where X is the number of colors among those creatures." }
    its([:artist]) { is_expected.to be_eql "Illus. Chris Rahn" }
    its([:power]) { is_expected.to be_eql "3/4" }
  end
end
