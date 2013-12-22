require 'ostruct'
require './lib/app/deck_list_parser'

describe DeckListParser do
  let(:params) { "4 Desecration Demon\r\n24 mountain\r\n\r\n3 shock\r\n" }

  context ".parse" do
    subject { DeckListParser.new(params).parse }

    it { should be_a Hash }
    its(:keys) { should be_eql Standard.parts }
  end

  context ".parse_part(part_name)" do
    context "with part name :main" do
      subject { DeckListParser.new(params).parse_part(:main) }

      let(:output) { [{copies:4, name:"Desecration Demon"}, {copies: 24, name:"mountain"}] }

      it { should eql output }
    end
    
    context "with part name :sideboard" do
      subject { DeckListParser.new(params).parse_part(:sideboard) }

      let(:output) { [{copies: 3, name: "shock"}] }

      it { should eql output }
    end
  end
end
