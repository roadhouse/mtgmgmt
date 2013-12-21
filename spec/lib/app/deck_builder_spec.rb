require "ostruct"

require "./lib/app/deck_builder"
require "./lib/app/deck_list_parser"


describe DeckBuilder do
  before { Deck.as_null_object }
  before { ["magmajet","moutain","shock"].each { |c| create(:card, name: c) } }

  let(:params) do
    { 
      name: "big red", 
      description: "desc", 
      card_list: "2 magmajet\r\n24 moutain\r\n\r\n3 shock\r\n"
    }
  end

  context ".build" do
    subject { DeckBuilder.new(params).build }

    it { should_not be_nil }
    it(:class) { should be_a Deck }
  end
end
