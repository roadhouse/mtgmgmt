require "./spec/support/vcr"
require "rspec/its"

require "./lib/laracna/laracna"

describe Laracna::Mtgdecks::IndexPage, :vcr do
  let(:decks_list_url) { "http://www.mtgdecks.net/decks/viewByFormat/39/page:1" }

  context "#urls" do
    subject { described_class.new(decks_list_url).urls }
    it { is_expected.to be_a Array }
    it { is_expected.to_not be_empty }
  end
end
