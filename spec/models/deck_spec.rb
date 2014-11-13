require 'spec_helper'

describe Deck do
  let!(:card) { create(:card) }

  context ".add_card" do
    subject { deck.add_card(2, "Magmajet", :main) }

    let(:deck) { Deck.new }

    before { deck.save! }

    its(:copies) { should be_eql 2 }
  end

  context ".main" do
    let(:deck) { Deck.new }

    subject { deck.main }

    before do
      deck.add_card(1, card.name, :main)
      deck.save!
    end

    it { should be_a Hash }
  end

  context ".sideboard" do
    subject { deck.sideboard.first }

    let(:deck) { Deck.new }

    before do
      deck.add_card(1, card.name, :sideboard)
      deck.save!
    end

    it { should be_a Array }
    its(:first) { is_expected.to be_eql "Instant" }
  end
end
