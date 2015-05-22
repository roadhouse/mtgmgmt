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
end
