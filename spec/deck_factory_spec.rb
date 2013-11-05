require 'spec_helper_active_record'
require "./app/models/deck_factory.rb"

describe DeckFactory do
  subject { DeckFactory.new({}) }
  before { Deck = stub.as_null_object }

  its(:deck) { should_not be_nil }
  its(:params) { should_not be_nil }

  context "when build a deck" do
    let(:params) do
      {
        main_deck: [ {quantity: 4, card_name: "young pyromancer"} ],
        sideboard: [ {quantity: 3, card_name: "wild ricochet"} ]
      }
    end

    subject { DeckFactory.new(params).build_deck }
  end

  context ".main_deck" do
    let(:params) do
      {
        main_deck: [ {quantity: 4, card_name: "young pyromancer"} ],
        sideboard: [ {quantity: 3, card_name: "wild ricochet"} ]
      }
    end

    subject { DeckFactory.new(params).main_deck }
    it { should be_a Array }
  end
end
