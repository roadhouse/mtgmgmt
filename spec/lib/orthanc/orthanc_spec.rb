require 'spec_helper'

describe Orthanc do
  before(:all) { create_list(:deck, 2, season: "BFZ-DTK-FRF-KTK-ORI") }

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

  context ".from_user" do
    let(:user) { create(:user) }
    let(:card1) { create(:card) }
    let(:card2) { create(:card, name: "Dispel", set:"BFZ") }
    let!(:inventory1) { create(:inventory, user: user, card: card1, copies: 4) }
    let!(:inventory2) { create(:inventory, user: user, card: card2) }

    subject { described_class.new(card_filters).from_user(user, inventory_filters) }

    context "with an empty filter string" do
      let(:card_filters) { "" }
      let(:inventory_filters) { {list: :game} }

      its(:size) { is_expected.to be_eql 2 }
    end

    context "search specific card on user collection" do
      let(:card_filters) { "Dis" }
      let(:inventory_filters) { {list: :game} }

      its(:size) { is_expected.to be_eql 1}
      its(:"first.card") { is_expected.to be_eql card2 }
    end

    context "filter cards by collection params" do
      let(:card_filters) { "Dis" }
      let(:inventory_filters) { {copies: 4, list: :game} }

      its(:size) { is_expected.to be_eql 1 }
      its(:"first.card") { is_expected.to be_eql card2 }
    end
  end
end
