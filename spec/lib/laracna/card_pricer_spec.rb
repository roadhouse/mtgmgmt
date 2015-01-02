require 'bigdecimal'
require 'bigdecimal/util'
require "./lib/laracna/card_pricer.rb"
require 'rspec/its'
require "./spec/support/vcr"

describe CardPricer do
  let(:card_name) { "Ashcloud Phoenix" }
  let(:card_pricer) { CardPricer.new(card_name) }

  context "#engine", :vcr do
    subject { card_pricer.engine }

    it(:engine) { is_expected.to_not be_nil }
  end

  context "#price", :vcr do
    subject { card_pricer.price }

    its(:class) { is_expected.to be_equal BigDecimal }
    its(:zero?) { is_expected.to be_falsy }
  end

  context "#card_url" do
    let(:card_shop_url) { "http://ligamagic.com.br/?view=cartas/card&card=Ashcloud%20Phoenix" }

    subject { card_pricer.card_url(card_name) }

    it { is_expected.to eq card_shop_url }
  end
end
