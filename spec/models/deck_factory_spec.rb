require 'spec_helper_active_record'
require "./app/models/deck_factory"
require "./app/models/deck"
# require "./app/models/card_deck"

describe DeckFactory do
  subject { DeckFactory.new({}) }

  its(:deck) { should_not be_nil }

  context ".build_deck" do
    let(:params) do
      {
        main: [ {quantity: 4, name: "young pyromancer"} ],
        sideboard: [ {quantity: 3, name: "wild ricochet"} ]
      }
    end

    subject { DeckFactory.new(params).build_deck }

    it { params should be_a Hash }

    # its(:"cards.size") { should eql 2 }
  end
end
