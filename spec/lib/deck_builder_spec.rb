require "rspec/its"
require "./lib/deck_builder"
require "spec_helper"
require "./app/models/deck"

describe DeckBuilder do
  before { create :deck, name: "Standard Daily #9286464 on 01/26/2016", source: "mtgo" }

  context "not duplicate deck" do
    let(:description) { "Jabs (4-0).Jabs.1stStandard Daily #9286464[6 Players] 26-Jan-2016" }
    let(:non_mtgo_deck) { build :deck, description: description, source: "mtgdecks" }

    subject { described_class.new(non_mtgo_deck.attributes).build }

    it { expect { subject }.to raise_error Laracna::DuplicateDeckError, non_mtgo_deck.url }
  end
end
