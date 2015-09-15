require "./spec/support/vcr"
require 'rspec/its'

require "./lib/laracna/scg/deck_page"
require "./lib/laracna/crawler_config"

describe Laracna::Scg::DeckPage, :vcr do
  context "with a valid deck page" do
    let(:deck_id) { 91127 }

    let(:attributes_list) do
      [:card_list, :description, :name, :url, :source]
    end

    let(:main) do
      [
        {:copies=>"4", :card=>"Den Protector"},
        {:copies=>"4", :card=>"Siege Rhino"},
        {:copies=>"4", :card=>"Courser of Kruphix"},
        {:copies=>"1", :card=>"Dragonlord Dromoka"},
        {:copies=>"1", :card=>"Tasigur, the Golden Fang"},
        {:copies=>"2", :card=>"Elspeth, Sun's Champion"},
        {:copies=>"1", :card=>"Ugin, the Spirit Dragon"},
        {:copies=>"2", :card=>"Forest"},
        {:copies=>"2", :card=>"Plains"},
        {:copies=>"2", :card=>"Caves of Koilos"},
        {:copies=>"4", :card=>"Llanowar Wastes"},
        {:copies=>"4", :card=>"Sandsteppe Citadel"},
        {:copies=>"4", :card=>"Temple of Malady"},
        {:copies=>"3", :card=>"Temple of Silence"},
        {:copies=>"4", :card=>"Windswept Heath"},
        {:copies=>"1", :card=>"Urborg, Tomb of Yawgmoth"},
        {:copies=>"4", :card=>"Abzan Charm"},
        {:copies=>"1", :card=>"Bile Blight"},
        {:copies=>"2", :card=>"Dromoka's Command"},
        {:copies=>"3", :card=>"Hero's Downfall"},
        {:copies=>"1", :card=>"Murderous Cut"},
        {:copies=>"1", :card=>"Silence the Believers"},
        {:copies=>"1", :card=>"Ultimate Price"},
        {:copies=>"1", :card=>"Languish"},
        {:copies=>"4", :card=>"Thoughtseize"}
      ]
    end

    let(:sideboard) do
      [
        {:copies=>"3", :card=>"Fleecemane Lion"},
        {:copies=>"1", :card=>"Gaea's Revenge"},
        {:copies=>"1", :card=>"Evolutionary Leap"},
        {:copies=>"1", :card=>"Ultimate Price"},
        {:copies=>"1", :card=>"Unravel the Æther"},
        {:copies=>"1", :card=>"Utter End"},
        {:copies=>"1", :card=>"Dragonlord Dromoka"},
        {:copies=>"1", :card=>"Whip of Erebos"},
        {:copies=>"2", :card=>"Duress"},
        {:copies=>"1", :card=>"Languish"},
        {:copies=>"2", :card=>"Tragic Arrogance"}
      ]
    end

    let(:config) { CrawlerConfig.new(:scg) }

    subject { Laracna::Scg::DeckPage.new(deck_id, config) }

    its(:description) { is_expected.to eql "1st Place at StarCityGames.com Invitational Qualifier on 9/5/2015" }
    its(:name) { is_expected.to be_eql "Abzan Control" }
    its(:main) { is_expected.to eql main }
    its(:sideboard) { is_expected.to eql sideboard }

    its(:"attributes.keys.sort") { should be_eql attributes_list.sort }
  end

  context "with a invalid deck page" do
    let(:deck_id) { 86785 }
    let(:config) { CrawlerConfig.new(:scg) }

    subject { described_class.new(deck_id, config) }

    its(:valid?) { is_expected.to be_falsy }
    
    context ".attributes" do
      subject { described_class.new(deck_id, config).attributes }

      it { expect  { subject }.to raise_error(Laracna::Scg::DeckPage::InvalidPageError) }
    end
  end

  context ".engine" do
    subject { described_class.new(double(to_s: "deck_id"), double).engine }

    it { is_expected.to be_a Nokogiri::HTML::Document }
  end

  context ".config" do
    subject { described_class.new(double, double).config }
    
    it { is_expected.to be_a CrawlerConfig }
  end
end
