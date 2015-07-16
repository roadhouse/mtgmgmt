require "./spec/support/vcr"
require 'rspec/its'

require "./lib/laracna/mtgo/deck_page"
require "./lib/laracna/crawler_config"

describe Laracna::Mtgo::DeckPage, :vcr do
  context "with a valid deck page" do
    let(:deck_url) { "http://magic.wizards.com/en/articles/archive/mtgo-standings/standard-daily-2015-07-15" }

    let(:attributes_list) do
      [:card_list, :description, :name, :url, :source]
    end

    context ".decks_nodes" do
      subject { Laracna::Mtgo::DeckPage.new(deck_url).decks_nodes }

      its(:size) { is_expected.to eq 11 }
    end

    context ".decks" do
      subject { Laracna::Mtgo::DeckPage.new(deck_url).decks }

      it { is_expected.to be_a Array }
      its(:size) { is_expected.to eq 11 }
      its(:first) { is_expected.to be_a Hash }
      its(:last) { is_expected.to be_a Hash }
    end
  end
end
