require "./lib/laracna/laracna"
require "./spec/support/vcr"
require "mtg_sdk"
require "spec_helper_active_record"

describe CardCrawler do
  context "engine" do
    subject { described_class.new("set").engine }

    it { is_expected.to_not be_nil }
  end
end
