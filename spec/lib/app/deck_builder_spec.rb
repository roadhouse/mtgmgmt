require "ostruct"

require "./lib/app/deck_builder"


describe DeckBuilder do
  # mocking Deck AR model and expliciting the interfaces 
  Deck = Struct.new(:valid?, :save!) do
    def add_card_by_name(params); end;
  end

  let(:params) do
    {
      main: [ {quantity: 4, name: "young pyromancer"} ],
      sideboard: [ {quantity: 3, name: "wild ricochet"} ]
    }
  end

  context ".build" do
    subject { DeckBuilder.new(params).build }

    it { should_not be_nil }
    it(:class) { should be_a Deck }
  end
end
