require 'spec_helper'

describe Deck do
  let!(:card) { create(:card) }

  context ".add_card" do
    subject { deck.add_card(2, "Magmajet", :main) }

    let(:deck) { Deck.new }

    before { deck.save! }

    its(:copies) { should be_eql 2 }
  end
end
