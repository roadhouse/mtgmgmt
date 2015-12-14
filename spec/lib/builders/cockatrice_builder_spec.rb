require 'spec_helper'

describe CockatriceBuilder do
  let(:deck) { create(:deck) }
  let(:builder) { described_class.new(deck) }

  context ".engine" do
    subject { builder.engine }

    it { is_expected.to be_eql Nokogiri::XML::Builder }
  end

  context ".output" do
    subject { builder.output }

    it { is_expected.not_to be_nil }
  end
end

