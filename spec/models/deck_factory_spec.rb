require 'spec_helper_active_record'
require "./app/models/deck_factory"
require "./app/models/deck"
require "./app/models/card_deck"

describe DeckFactory do
  subject { DeckFactory.new({}) }

  its(:deck) { should_not be_nil }
  its(:params) { should_not be_nil }

  context ".build_deck" do
    let(:params) do
      {
        main_deck: [ {quantity: 4, card_name: "young pyromancer"} ],
        sideboard: [ {quantity: 3, card_name: "wild ricochet"} ]
      }
    end

    subject { DeckFactory.new(params).build_deck }

    it { should_not be_nil }
    it { should be_a Deck }

    its(:"cards.size") { should eql 2 }
  end
end
