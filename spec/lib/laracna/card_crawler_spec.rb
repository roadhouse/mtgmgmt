require "./spec/support/vcr"
require "spec_helper_active_record"
require "json"
require "ostruct"
require "./app/models/card"

require "./lib/laracna/card_crawler.rb"

describe CardCrawler do

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

    its([:name]) { is_expected.to be_eql "General Tazri" }
    its([:mana_cost]) { is_expected.to be_eql "4W" }
    its([:ctype]) { is_expected.to be_eql "Legendary Creature - Human Ally" }
    its([:original_text]) { is_expected.to be_eql "When General Tazri enters the battlefield, you may search your library for an Ally creature card, reveal it, put it into your hand, then shuffle your library.\nWUBRG: Ally creatures you control get +X/+X until end of turn, where X is the number of colors among those creatures." }
    its([:artist]) { is_expected.to be_eql "Illus. Chris Rahn" }
    its([:power]) { is_expected.to be_eql "3/4" }
  end

  context '.ar_attributes' do
    subject { crawler.ar_attributes }

    it { is_expected.to include :name }
    it { is_expected.to include :mana_cost }
    it { is_expected.to include :ctype }
    it { is_expected.to include :original_text }
    it { is_expected.to include :artist }
    it { is_expected.to include :power }
  end
end
