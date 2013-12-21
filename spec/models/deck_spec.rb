require 'spec_helper'

describe Deck do
  let!(:card) { create(:card) }

  context ".add_card_by_name" do
    subject { deck.add_card_by_name("Magmajet", 2) }

    let(:deck) { Deck.new }

    before { deck.save! }

    its(:copies) { should  == 2 }
  end
end
