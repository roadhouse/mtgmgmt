require "./spec/support/vcr"
require 'rspec/its'

require "./lib/laracna/mtgdecks/index_page"
require "./lib/laracna/crawler_config"

describe Laracna::Mtgdecks::IndexPage, :vcr do
  let(:config) { CrawlerConfig.new(:mtgdecks) }
  let(:decks_list_url) {"http://www.mtgdecks.net/decks/viewByFormat/39/page:1"}

  context "#deck_nodes" do
    subject { described_class.new(decks_list_url, config).deck_nodes }
    it { is_expected.to_not be_nil }
    its(:size) { is_expected.to_not be_zero }
  end

  context "#decks_ids" do
    subject { described_class.new(decks_list_url, config).decks_ids }
    it { is_expected.to be_a Array }
    it { is_expected.to_not be_empty }
  end
end
