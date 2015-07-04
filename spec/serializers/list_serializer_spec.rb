require 'spec_helper'

describe ListSerializer do
  context "#load" do
    subject { described_class.load(list) }

    context "with a complete hash" do
      let(:list) { { 'main' => { 'card_name' => 2 } } }

      its(:keys) { is_expected.to eq ["main"] }
      its(["main"]) { is_expected.to be_a Array }
      its([:main]) { is_expected.to be_a Array }
    end

    context "with an empty hash" do
      let(:list) { {} }

      it { is_expected.to eq({}) }
    end
  end

  context "#hash_to_array(card_name: 2)" do
    let(:list) { { "card_name" => 2 } }

    subject { described_class.hash_to_array(list) }

    it { is_expected.to be_a Array }
    its(:size) { is_expected.to eql 2 }
    its(:first) { is_expected.to be_a Card }
    its(:"first.name") { is_expected.to eq "card_name" }
    its(:last) { is_expected.to be_a Card }
    its(:"last.name") { is_expected.to eq "card_name" }
  end
end
