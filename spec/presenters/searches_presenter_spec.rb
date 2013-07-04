# require "bundler"
# Bundler.setup(:default, :test)

require "rspec/matchers"
require "mocha"

require "active_support/core_ext/module/delegation"
require "./app/presenters/base_presenter.rb"
require "./app/presenters/searches_presenter.rb"

describe SearchesPresenter do
  context "exposed attributes" do
    exposed_attributes = [:power, :toughness, :name, :manacost, :text]
    exposed_attributes.each do |exposed_attribute|
      
      context ".#{exposed_attribute.to_s}" do
        let(:expected) { "card.#{exposed_attribute}" }
        let(:card) { mock("Card", exposed_attribute => expected) }

        subject { described_class.new(card).send(exposed_attribute) }

        it { should eql expected  }
      end

    end
  end

  context ".body" do
    subject { described_class.new(card).body }

    context "with a body" do
      let(:card) { mock("Card", power: 1, toughness: 1) }
      let(:expected)  { "creature" }

      it { should eql expected }
    end

    context "without body" do
      let(:card) { mock("Card", power: nil, toughness: nil) }
      let(:expected) { [] }
      
      it { should eql expected }
    end
  end

  context ".card_deck" do
    require "active_record"
    require "./app/models/card_deck"
    require "./app/models/card"
    connection_info = YAML.load_file("config/database.yml")["test"]
    ActiveRecord::Base.establish_connection(connection_info)

    let(:card) { Card.new }
    subject { described_class.new(card).card_deck }

    its(:card) { should eq card }
    it { should be_a CardDeck }
    it { should be_new_record }
  end

  context ".avaiable_decks" do
    require "active_record"
    require "./app/models/deck"
    connection_info = YAML.load_file("config/database.yml")["test"]
    ActiveRecord::Base.establish_connection(connection_info)
    Deck.delete_all

    let!(:carddeck) { Deck.create(name: "boros") }
    let(:expected) { [[carddeck.name, carddeck.id]] }

    subject { described_class.new([]).avaiable_decks }

    it { should eq expected }
  end
end
