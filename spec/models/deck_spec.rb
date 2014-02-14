require 'spec_helper'

describe Deck do
  let!(:card) { create(:card) }

  context ".add_card" do
    subject { deck.add_card(2, "Magmajet", :main) }

    let(:deck) { Deck.new }

    before { deck.save! }

    its(:copies) { should be_eql 2 }
    
    context "with a inexistent card" do
      subject { deck.add_card(2, name, :main) }

      let(:name) { "inexistent card" } 
      let(:deck) { Deck.new }

      specify { expect { subject }.to raise_error(name) }
    end
  end

  context ".main" do
    subject { deck.main.first }

    let(:deck) { Deck.new }

    before do
      deck.add_card(1, card.name, :main)
      deck.save!
    end

    its([:copies]) { should be_eql 1 }
    its([:card]) { should be_eql card }
  end

  context ".sideboard" do
    subject { deck.sideboard.first }

    let(:deck) { Deck.new }

    before do
      deck.add_card(1, card.name, :sideboard)
      deck.save!
    end

    its([:copies]) { should be_eql 1 }
    its([:card]) { should be_eql card }
  end
end
