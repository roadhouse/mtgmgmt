require 'ostruct'
require './lib/app/deck_list_parser'

describe DeckListParser do
  let(:params) { "4 magmajet\n24 mountain\n\n3 shock" }

  context ".parse" do
    subject { DeckListParser.new(params).parse }

    it { should be_a Hash }
    its(:keys) { should be_eql Standard.parts }
  end

  context ".parse_part(part_name)" do
    context "with part name :main" do
      subject { DeckListParser.new(params).parse_part(:main) }

      let(:output) {
        [{quantity:4, name:"magmajet"}, {quantity: 24, name:"mountain"}]
      }

      it { should eql output }
    end
    
    context "with part name :sideboard" do
      subject { DeckListParser.new(params).parse_part(:sideboard) }

      let(:output) { [{quantity: 3, name: "shock"}] }

      it { should eql output }
    end
  end
end
