require "spec_helper"

describe Orthanc do
  before(:all) { create_list :deck, 2, season: Orthanc::SEASON }

  let(:orthanc) { described_class.new }

  describe ".new" do
    subject { orthanc }

    it { expect { subject }.to_not raise_error }
  end

  context ".top_decks" do
    subject { orthanc.top_decks }

    it { is_expected.to be_a ActiveRecord::Relation }

    context "collection item " do
      subject { orthanc.top_decks.first }

      it { is_expected.to be_a Deck }

      its(:name) { is_expected.to eq "Jeskai Heroic" }
    end
  end

  context ".from_user" do
    let(:user) { create :user }
    let(:card1) { create :card }
    let(:card2) { create :card, name: "Dispel", set: "BFZ" }
    let!(:inventory1) { create :inventory, user: user, card: card1, copies: 4 }
    let!(:inventory2) { create :inventory, user: user, card: card2  }

    subject { described_class.new(card_filters).from_user user }

    context "with an empty filter string" do
      let(:card_filters) { "" }

      its(:size) { is_expected.to be_eql 2 }
    end

    context "with a limit param" do
      let(:card_filters) { "limit: 1" }

      its(:size) { is_expected.to be_eql 1 }
    end

    context "search specific card on user collection" do
      let(:card_filters) { "Dis" }
      let(:inventory_filters) { nil }

      its(:size) { is_expected.to be_eql 1 }
      its(:"first.card") { is_expected.to be_eql card2 }
    end
  end
end
