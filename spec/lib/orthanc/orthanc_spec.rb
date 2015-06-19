require 'spec_helper'

describe Orthanc do
  before(:all) { create_list(:deck, 2, season: "BNG-DTK-FRF-JOU-KTK-M15-THS") }

  let(:orthanc) { described_class.new({}) }

  context ".top_decks" do
    subject { orthanc.top_decks }

    it { is_expected.to be_a ActiveRecord::Relation }

    context "collection item " do 
      subject { orthanc.top_decks.first }

      it { is_expected.to be_a Deck }

      its(:name) { is_expected.to eq "red deck wins" }
      its(:quantity) { is_expected.to eq 2 }
    end
  end

  context ".param_builder" do
    subject { described_class.new({}).param_builder(filter_string) }
    
    context "with only arbitrary string" do
      let(:filter_string) { "brimaz" }

      it { is_expected.to eq({name: "brimaz"}) }
    end

    context "with a token filter" do
      let(:filter_string) { "brimaz t:creature" }

      it { is_expected.to eq({t: "creature", name: "brimaz"}) }
    end
  end
end
