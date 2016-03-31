require "./spec/support/vcr"
require "rspec/its"

require "./lib/laracna/laracna"

describe Laracna::Mtgo::IndexPage, :vcr do
  context "#deck_nodes" do
    subject { described_class.new(1).urls }

    it { is_expected.to be_a Array }
  end
end
