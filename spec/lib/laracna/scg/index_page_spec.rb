require "./spec/support/vcr"
require 'rspec/its'

require "./lib/laracna/mtgdecks/index_page"
require "./lib/laracna/mtgdecks/page_url"

describe Laracna::Mtgdecks::IndexPage, :vcr do
  let(:decks_list_url) {"http://www.mtgdecks.net/decks/viewByFormat/34/page:1"}

  context "#deck_nodes" do
    subject { described_class.new(decks_list_url).deck_nodes }
    it { is_expected.to_not be_nil }
    its(:size) { is_expected.to_not be_zero }
  end

  context "#decks_ids" do
    subject { described_class.new(decks_list_url).decks_ids }
    it { is_expected.to be_a Array }
    it { is_expected.to_not be_empty }
  end
end
