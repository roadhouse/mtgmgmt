require 'spec_helper'

describe Orthanc do
  before(:all) { create_list(:deck, 2, season: "BFZ-DTK-FRF-KTK-M15-ORI") }

  let(:orthanc) { described_class.new("") }

  context ".top_decks" do
    subject { orthanc.top_decks }

    it { is_expected.to be_a ActiveRecord::Relation }

    context "collection item " do 
      subject { orthanc.top_decks.first }

      it { is_expected.to be_a Deck }

      its(:name) { is_expected.to eq "Jeskai Heroic" }
      # its(:quantity) { is_expected.to eq 2 }
    end
  end

  context ".param_builder" do
    subject { orthanc.param_builder(filter_string) }
    
    context "with only arbitrary string" do
      let(:filter_string) { "brimaz" }

      it { is_expected.to eq({name: "brimaz"}) }
    end

    context "with only arbitrary string with spaces" do
      let(:filter_string) { "elmo dos de" }

      it { is_expected.to eq({name: "elmo dos de"}) }
    end

    context "with a token filter" do
      let(:filter_string) { "brimaz Type:creature" }

      it { is_expected.to eq({type: "Creature", name: "brimaz"}) }
    end

    context "ignoring space after filter separator" do
      let(:filter_string) { "brimaz Type: creature" }

      it { is_expected.to eq({type: "Creature", name: "brimaz"}) }
    end
  end
end
