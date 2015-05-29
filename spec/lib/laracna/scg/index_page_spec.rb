require "./spec/support/vcr"
require 'rspec/its'

require "./lib/laracna/scg/index_page"
require "./lib/laracna/scg/page_url"

describe Laracna::Scg::IndexPage, :vcr do
  context "#deck_nodes" do
    subject { described_class.new(1).deck_nodes }

    it { is_expected.to be_a Array }
    its(:size) { is_expected.to be_eql 100 }
  end

  context "#decks_ids" do
    subject { described_class.new(1).decks_ids }

    it { is_expected.to be_a Array }
    its(:size) { is_expected.to be_eql 100 }
    its(:first) { is_expected.to be_a Integer}
    its(:last) { is_expected.to be_a Integer}
  end
end
