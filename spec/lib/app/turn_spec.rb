require 'ostruct'
require './lib/app/turn.rb'

describe Turn do
  describe "500. General" do
    describe "500.1." do
      context "A turn consists of five phases, in this order: beginning, precombat main, combat, postcombat main, and ending." do
        subject { Turn.new }
        its(:phases) { should == [Beginning, :precombat_main, :combat, :postcombat_main, :ending] }
      end
    end
  end
end
