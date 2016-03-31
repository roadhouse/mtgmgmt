require "./spec/support/vcr"
require "rspec/its"

require "./lib/laracna/laracna"

describe Laracna::Scg::IndexPage, :vcr do
  context "#urls" do
    subject { described_class.new(1).urls }

    it { is_expected.to be_a Array }
    its(:size) { is_expected.to be_eql 100 }
  end
end
